class TasksController < ApiController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    create_entries_for_today
    modified = @tasks.map do |task|
      hashed = task.attributes
      hashed[:entries] = task.entries.where(entries_query).order(entry_date: :desc).map { |entry| entry_attributes(entry) }
      hashed
    end
    json_response(modified)
  end

  def create
    task = current_user.tasks.create!(task_params)
    entry = task.entries.create!({ entry_date: today });
    param = task.attributes
    param[:entries] = [entry_attributes(entry)]
    json_response(param, :created)
  end

  def update
    @task.update(update_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  def show
    create_entries_for_today
    task = current_user.tasks.find(params[:id])
    hashed = task.attributes
    hashed[:entries] = task.entries.where(entries_query).order(entry_date: :desc).map { |entry| entry_attributes(entry) }
    json_response(hashed)
  end

  def for_group
    create_entries_for_today
    tasks = current_user.tasks.where(group_id: params[:group_id])
    modified = tasks.map do |task|
      hashed = task.attributes
      hashed[:entries] = task.entries.where(entries_query).order(entry_date: :desc).map { |entry| entry_attributes(entry) }
      hashed
    end
    json_response(modified)
  end

  private
  
  def task_params
    params.permit([:title, :group_id])
  end

  def update_params
    params.permit([:title])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def entry_attributes(entry)
    return nil unless entry
    { id: entry.id, entry_date: entry.entry_date, task_id: entry.task_id, duration: entry.duration }
  end

  def entries_query
    date = params[:date]
    start_date = params[:start]
    end_date = params[:end]

    if date
      { entry_date: date }
    elsif start_date && end_date
      ['entry_date >= ? and entry_date <= ?', start_date, end_date]
    elsif start_date
      ['entry_date >= ?', start_date]
    elsif end_date
      ['entry_date <= ?', end_date]
    else
      { entry_date: today }
    end
  end

  def create_entries_for_today
    @tasks = current_user.tasks
    entries = Entry.where({ task_id: @tasks.map(&:id), entry_date: today })
    if entries.size.zero?
      time = Time.now.utc
      params = @tasks.map { |t| { task_id: t.id, entry_date: today, created_at: time, updated_at: time  } }
      Entry.insert_all(params)
    end
  end
end
