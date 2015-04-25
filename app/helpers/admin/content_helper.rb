module Admin::ContentHelper
  def sortable(field, name=nil)
    name ||= field.humanize
    direction = params[:direction]
    if field == params[:field]
      if direction == field
        direction = 'desc'
      elsif direction == 'asc'
        name += ' &#x25BC;'
        direction = 'desc'
      elsif direction == 'desc'
        name += ' &#x25B2;'
        direction = 'asc'
      end
    end
    direction ||= 'asc'

    return link_to name.html_safe, params.merge(:field => field, direction: direction)
  end
end
