module RouteHelper

  def main_menu
    menu = [home_route, main_program_route, sponsers_route, articles_route, get_involved_route]
    if AnnualSchedule.cfp_open?
      menu.push submissions_route
    elsif AnnualSchedule.registration_open?
      menu.push register_route
    elsif AnnualSchedule.post_week?
      menu.push schedule_route
    end
    if AnnualSchedule.voting_open?
      menu.push voting_route
    end
    menu
  end

  def program_routes
    [program_route, tracks_route, clusters_route, basecamp_route, headline_events_route]
  end

  def social_media_routes
    [
      { icon: "fa-twitter", label: "twitter", link: "https://twitter.com/denstartupweek" },
      { icon: "fa-facebook-f", label: "facebook", link: "https://www.facebook.com/DenverStartupWeek" },
      { icon: "fa-linkedin-in", label: "linkedin", link: "https://www.linkedin.com/company/denver-startup-week/" },
      { icon: "fa-youtube", label: "youtube", link: "https://www.youtube.com/c/denverstartupweek" },
      { icon: "fa-medium-m", label: "medium", link: "https://medium.com/denver-startup-week" }
    ]
  end

  def home_route
    {
      path: "",
      label: "home"
    }
  end

  def sponsers_route
    {
      path: "sponsers",
      label: "sponsers"
    }
  end

  def get_involved_route
    {
      path: "get-involved",
      label: "get involved"
    }
  end

  def schedule_route
    {
      path: schedules_path,
      label: "schedule"
    }
  end

  def submissions_route
    {
      path: new_submission_path,
      label: "Submit a Talk"
    }
  end

  def voting_route
    {
      path: submissions_path,
      label: "Panel Picker"
    }
  end

  def register_route
    {
      path: schedules_path,
      label: "Register To Attend"
    }
  end

  def main_program_route
    {
      path: "program",
      label: "program",
      nested_routes: program_routes
    }
  end

  def articles_route
    {
      path: articles_path,
      label: "Articles"
    }
  end

  def program_route
    {
      path: "program",
      label: "overview"
    }
  end

  def tracks_route
    {
      path: "program/tracks",
      label: "tracks"
    }
  end

  def track_detail_route(name)
    {
       path: "program/tracks/#{name}",
       label: name
    }
  end

  def clusters_route
    {
      path: "program/clusters",
      label: "clusters"
    }
  end

  def basecamp_route
    {
      path: "basecamp",
      label: "basecamp"
    }
  end

  def headline_events_route
    {
      path: "program/headline-events",
      label: "headline events"
    }
  end

  def active_link_class(route)
    current_path?(route) ? "is-active" : ""
  end

  def menu_starting_nav
    starting_nav = ""
    main_menu.each do |item|
      next unless item[:nested_routes].present?
      if item[:nested_routes].any? { |r| r[:path] == request_path }
        starting_nav = item[:label]
      end
    end
    starting_nav
  end

  private

  def request_path
    request.path[1...request.path.length]
  end

  def current_path?(route)
    request_path == route[:path]
  end

end