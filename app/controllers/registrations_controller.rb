class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    @user = User.new(sign_up_params)
    if @user.save
      init_user_tasks
      render json: @user
    else
      json_response({ message: 'Email has already been taken' }, :unauthorized)
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end

  def init_user_tasks
    time = Time.now.utc
    tasks = DefaultTask.all.reduce([]) { |accm, t| accm << { title: t.title, user_id: @user.id, group_id: t.group_id, created_at: time, updated_at: time } }
    Task.insert_all(tasks)
  end
end
