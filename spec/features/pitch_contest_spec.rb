require 'spec_helper'

feature 'Submitting and voting on pitch contest applications' do

  let!(:user) do
    create(:user, email: 'test@example.com', password: 'password')
  end

  let!(:track) do
    Track.create! name: 'Founder',
                  is_submittable: true
  end

  let!(:pitch) do
    PitchContest::Entry.create!(name: 'Globex Corporation',
                                video_url: 'https://youtu.be/oruC0LSuYgM')
  end

  describe 'when voting is open' do
    around(:each) do |example|
      travel_to EventSchedule::PITCH_VOTING_OPEN_DATE + 1.day do
        example.run
      end
    end

    scenario 'User votes for an entry when already signed in' do
      login_as user, scope: :user
      visit '/pitch'
      click_link 'Vote Now'
      expect(page).to have_content('Globex Corporation')

      click_link "Vote for 'Globex Corporation'"
      expect(page).to have_css('.vote-count', text: '1 vote')

      # Clicking twice should have no effect
      click_link "Vote for 'Globex Corporation'"
      expect(page).to have_css('.vote-count', text: '1 vote')
    end

    scenario 'User votes for a session after being prompted to sign in and register' do
      visit '/pitch'
      click_link 'Vote Now'
      expect(page).to have_content('Globex Corporation')

      click_link "Vote for 'Globex Corporation'"
      fill_in 'E-mail Address', with: 'test@example.com'
      fill_in 'Password', with: 'password', match: :prefer_exact
      click_button 'Sign In'

      select 'Male', from: 'registration_gender'
      select '25-34 years old', from: 'registration_age_range'
      select 'Founder', from: 'registration_track_id'
      fill_in 'registration_company', with: 'Example.com'
      fill_in 'registration_primary_role', with: 'Developer'
      fill_in 'registration_zip', with: '12345'
      click_button 'Register'

      click_link "Vote for 'Globex Corporation'"
      expect(page).to have_css('.vote-count', text: '1 vote')

      # Clicking twice should have no effect
      click_link "Vote for 'Globex Corporation'"
      expect(page).to have_css('.vote-count', text: '1 vote')
    end
  end

  describe 'when voting is closed' do
    around(:each) do |example|
      travel_to EventSchedule::PITCH_VOTING_CLOSE_DATE + 1.day do
        example.run
      end
    end

    scenario 'User tries to access voting when feedback is closed' do
      visit '/pitch'
      expect(page).not_to have_content('Vote Now')
    end
  end

end