class EntriesController < ApiController
  before_action :set_entry, only: [:show, :update, :destroy]

  def index
    @entries = entries_for_today
    if @entries.size.zero?
      Task.all.map { |task| task.entries.create({ entry_date: today }) }
      @entries = entries_for_today
    end
    json_response(@entries)
  end

  def show
    json_response(@entry)
  end

  def update
    @entry.update(entry_params)
    head :no_content
  end

  def destroy
    @entry.destroy
    head :no_content
  end

  private

  def entry_params
    params.require(:entry).permit(%i[entry_date, duration])
  end

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def today
    DateTime.current.to_date
  end

  def entries_for_today
    Entry.where(entry_date: today).includes(:task)
  end
end
