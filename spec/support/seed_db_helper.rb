module SeedDbHelper
  def seed_default_tasks
    Group.destroy_all
    DefaultTask.destroy_all

    Group.create([{ title: 'Work' }, { title: 'Essentials' }, { title: 'Leisure' }])

    DefaultTask.create([
                         {
                           title: 'Study', group: Group.find_by_title('Work')
                         },
                         {
                           title: 'Office', group: Group.find_by_title('Work')
                         },
                         {
                           title: 'Meals', group: Group.find_by_title('Essentials')
                         },
                         {
                           title: 'Sleep', group: Group.find_by_title('Essentials')
                         },
                         {
                           title: 'Games', group: Group.find_by_title('Leisure')
                         },
                         {
                           title: 'Exercise', group: Group.find_by_title('Leisure')
                         }
                       ])
  end

  def init_user_tasks
    time = Time.now.utc
    tasks = DefaultTask.all.reduce([]) do |accm, t|
      accm << { title: t.title, user_id: user.id, group_id: t.group_id, created_at: time, updated_at: time }
    end
    Task.insert_all(tasks)
  end
end
