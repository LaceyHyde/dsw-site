class TracksController < ApplicationController
  def show
    track_name = params[:name].titleize.downcase
    @track = Track
      .where(has_detail_page: true)
      .where("lower(name) = ?", track_name)
      .first!
    @publishings = Publishing.for_track(track_name).page(params[:page]).per(12)

    respond_to do |format|
      format.html do
        render template: "site/program/tracks/show"
      end

      format.js do
        render json: {fragment: render_to_string(partial: "layouts/shared/publishings_list_items",
                                                 locals: {list: @publishings}, formats: [:html]),
                      next_url: url_for(page: Integer(params[:page] || 1) + 1),
                      last_page: @publishings.last_page?,}
      end
    end
  end
end
