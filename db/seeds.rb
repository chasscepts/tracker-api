Group.destroy_all
Task.destroy_all

Group.create([{ title: 'Work' }, { title: 'Essentials' }, { title: 'Leisure' }])

Task.create([
  { title: 'Study', group: Group.find_by_title('Work') },
  { title: 'Office', group: Group.find_by_title('Work') },
  { title: 'Meals', group: Group.find_by_title('Essentials') },
  { title: 'sleep', group: Group.find_by_title('Essentials') },
  { title: 'Games', group: Group.find_by_title('Leisure') },
  { title: 'Exercise', group: Group.find_by_title('Leisure') }
])
