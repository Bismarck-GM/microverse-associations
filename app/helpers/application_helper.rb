module ApplicationHelper
  def render_validation_errors(resource)
    render 'partials/form_errors', resource: resource if resource.errors.any?
  end

  def render_flash(type)
    if type == :notice
      render 'partials/flash_notice' if flash[:notice]
    elsif type == :error
      render 'partials/flash_error' if flash[:error]
    else
      raise 'Unknown flash type'
    end
  end

  def render_logout_link()
    return unless user_logged_in

    link_to destroy_session_path, method: :delete do
      "<button aria-label=\"Close\" id='logout'></button>".html_safe
    end
  end
end
