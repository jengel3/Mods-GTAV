module Admin::AdminHelper
  def current_panel(controller, action = "index")
    current_page?(controller: controller, action: action) ? 'active_subcategory' : ''
  end
end
