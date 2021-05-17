RailsAdmin.config do |config|
  #config.included_models = ["User", "Course"]
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.parent_controller = "::ApplicationController"
  config.authorize_with do |controller|
    unless current_user && current_user.admin?
      redirect_to(
        main_app.root_path,
        alert: I18n.t("admin.permit")
      )
    end
  end
  config.main_app_name = ["Admin", ""]

  config.actions do
    dashboard       
    index                      
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
