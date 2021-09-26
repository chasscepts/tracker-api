Group.destroy_all
DefaultTask.destroy_all

Group.create([{ title: 'Work' }, { title: 'Essentials' }, { title: 'Leisure' }])

DefaultTask.create([
  { title: 'Study', group: Group.find_by_title('Work') },
  { title: 'Office', group: Group.find_by_title('Work') },
  { title: 'Meals', group: Group.find_by_title('Essentials') },
  { title: 'Sleep', group: Group.find_by_title('Essentials') },
  { title: 'Games', group: Group.find_by_title('Leisure') },
  { title: 'Exercise', group: Group.find_by_title('Leisure') }
])
