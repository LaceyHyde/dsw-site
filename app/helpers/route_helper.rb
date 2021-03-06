module RouteHelper
  def admin_root_path
    {
      path: "/admin",
      label: "Admin",
    }
  end

  def main_menu
    menu = [home_route, main_program_route, main_about_route, sponsors_route, main_get_involved_route, articles_route]

    menu.push schedule_route if registration_open? || AnnualSchedule.post_week?
    menu.push register_route if registration_open? && !registered?
    menu.push voting_route if AnnualSchedule.voting_open?

    menu
  end

  def program_routes
    routes = [program_route, tracks_route]
    routes.push clusters_route unless Cluster.active.empty?
    routes
  end

  def about_routes
    [about_route, team_route, faq_route, assets_route]
  end

  def social_media_routes
    [
      {icon: "fa-twitter", label: "twitter", link: "https://twitter.com/denstartupweek"},
      {icon: "fa-facebook-f", label: "facebook", link: "https://www.facebook.com/DenverStartupWeek"},
      {icon: "fa-linkedin-in", label: "linkedin", link: "https://www.linkedin.com/company/denver-startup-week/"},
      {icon: "fa-youtube", label: "youtube", link: "https://www.youtube.com/c/denverstartupweek"},
    ]
  end

  def footer_nav_routes
    routes = [faq_route, assets_route, code_of_conduct_route, contact_us_route]
    routes.unshift admin_root_path if signed_in? && current_user.is_admin?
    routes
  end

  def contact_us_route
    {
      path: new_general_inquiry_path,
      label: "Contact Us",
    }
  end

  def code_of_conduct_route
    {
      path: "/code-of-conduct",
      label: "Code of Conduct",
    }
  end

  def home_route
    {
      path: "/",
      label: "Home",
    }
  end

  def main_about_route
    {
      path: "/about",
      label: "About",
      nested_routes: about_routes,
    }
  end

  def about_route
    {
      path: "/about",
      label: "Overview",
    }
  end

  def team_route
    {
      path: "/about/team",
      label: "Team",
    }
  end

  def faq_route
    {
      path: "/about/faq",
      label: "FAQ",
    }
  end

  def assets_route
    {
      path: "/about/assets",
      label: "Assets",
    }
  end

  def sponsor_route
    {
      path: "/get-involved/sponsor",
      label: "Sponsor",
    }
  end

  def sponsors_route
    {
      path: "/sponsors",
      label: "Sponsors",
    }
  end

  def main_get_involved_route
    {
      path: "/get-involved",
      label: "Get Involved",
    }
  end

  def get_involved_route
    {
      path: "/get-involved",
      label: "Overview",
    }
  end

  def volunteer_route
    {
      path: "https://www.cervistech.com/acts/console.php?console_id=0282&console_type=event&ht=1",
      label: "Volunteer",
    }
  end

  def present_route
    {
      path: new_submission_path,
      label: "Present",
    }
  end

  def content_route
    {
      path: "/get-involved/content",
      label: "Content",
    }
  end

  def schedule_route
    {
      path: schedules_path,
      label: "Schedule",
    }
  end

  def submissions_route
    {
      path: new_submission_path,
      label: "Submit a Talk",
    }
  end

  def voting_route
    {
      path: submissions_path,
      label: "Vote",
    }
  end

  def register_route
    {
      path: new_registration_path,
      label: "Register to Attend",
    }
  end

  def main_program_route
    {
      path: "/program",
      label: "Program",
      nested_routes: program_routes,
    }
  end

  def articles_route
    {
      path: articles_path,
      label: "Articles",
    }
  end

  def program_route
    {
      path: "/program",
      label: "Overview",
    }
  end

  def tracks_route
    {
      path: "/program/tracks",
      label: "Tracks",
    }
  end

  def track_detail_route(name)
    {
      path: "/program/tracks/#{name}",
      label: name,
    }
  end

  def clusters_route
    {
      path: "/program/clusters",
      label: "Clusters",
    }
  end

  def basecamp_route
    {
      path: "/program/tracks/Basecamp",
      label: "Basecamp",
    }
  end

  def active_link_class(route)
    current_path?(route) ? "is-active" : ""
  end

  def menu_starting_nav
    starting_nav = ""
    main_menu.each do |item|
      next unless item[:nested_routes].present?
      if item[:nested_routes].any? { |r| r[:path] == request.path }
        starting_nav = item[:label].parameterize
      end
    end
    starting_nav
  end

  def came_from_registration?
    session[:came_from_registration]
  end

  def came_from_program_tracks?
    return false if request.referer.nil?
    request.referer.include?("program/tracks")
  end

  def back_to_label(default)
    return default unless request.referer
    return default if different_referer_host?
    return default if request.referer.include?(default)
    matched_path = request.referer.match(/([^\/]+$)/)
    return "home" if matched_path.nil?
    URI.decode(matched_path[1].split("?").first)
  end

  def back_to_path(path_check, default_path)
    return default_path unless request.referer.present?
    return default_path if different_referer_host?
    return default_path if request.referer.include?(path_check)
    request.referer
  end

  private

  def current_path?(route)
    request.path == route[:path]
  end

  def different_referer_host?
    request.referer.present? && !URI(request.referer).host.include?(request.host)
  end
end
