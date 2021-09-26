![](https://img.shields.io/badge/Microverse-blueviolet)

# Tracker

> Tracker is an API to track the amount of time a user is spending on common daily tasks. It exposes the api to create, delete, get and update Tasks. The Tasks are organized into three major categories and a user can make CRUD calls to add or remove tasks from them.

## Documentation

### BaseUrl - `https://time-max.herokuapp.com/`

#### The API exposes the following public endpoints

- `get /groups` - retrieve a list of all groups.
- `get /tasks` - retrieve a list of user tasks. This accepts 3 query params as follows
  - `date` - when provided, only the entry for this date will be included in the response.
  - `start` - when provided, entries earlier than this date will not be included in the response
  - `end` - when provided, entries later than this date will not be included in the response.
  ### NOTE: All dates must be in the format `yyyy-mm-dd`
  Example response
  ```json
    [
      {
        "id": 1,
        "title": "A Task",
        "group_id": 2,
        "user_id": 3,
        "entries": [
          {
            "id": 1,
            "entry_date": "2021-09-22",
            "task_id": 1,
            "duration": 500
          },
          {
            "id": 2,
            "entry_date": "2021-09-21",
            "task_id": 1,
            "duration": 200
          }
        ]
      }
    ]
  ```
- `get /tasks/:id` - retrieve the task with given id. It also accepts the query params as above.
- `post /groups/:id/tasks/` - create a task with title provided in the body. The only accepted parameter is title.

  Example accepted parameters
  ```json
  { "title": "A Task" }
  ```
- `put /tasks/` - update a task with title provided in the body. Accepts the same parameters as `post`.
- `delete /tasks/:id` - remove task given by id from the database.
- `put /entries/:id` - update given entry duration.

## Built With

- Ruby On Rails
- Postgresql

## Versions
- ruby '2.7.2'
- Rails >= 6.1.3

## Getting Started

To get a local copy of the project up and running, follow these steps.

```bash
  # clone repository and cd into its directory
  
  $ git clone https://github.com/chasscepts/tracker-api.git
  $ cd tracker-api

  # install gems
  $ bundle install

  # install npm dependencies
  $ yarn install

  # create database, run migration and seed the category table
  $ rails db:create
  $ rails db:migrate
  $ rails db:seed

  # Run Tests (RSpec is used for testing)
  $ bundle exec rspec

  # Run Ruby Linter
  $ rubocop .

```

##

## Authors

👤 **Obetta Francis**

[![](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/chasscepts) [![](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/chasscepts) [![](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/chasscepts/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/chasscepts/tracker-api/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Huge Thanks to Microverse community for all their supports.
- I appreciate everyone whose work was used in this project.

## 📝 License

This project is [MIT](./LICENSE)
