module EventHelper
  def render_invite_form(event)
    render 'events/invite_form' if current_user.id == event.creator_id
  end
end
