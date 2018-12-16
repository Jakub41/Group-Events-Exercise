# GROUP EVENTS EXERCISE

### Assumption

A group event will be created by an user. The group event should run for a whole number of days e.g.. 30 or 60. There should be attributes to set and update the start, end or duration of the event (and calculate the other value). The event also has a name, description (which supports formatting) and location. The event should be draft or published. To publish all of the fields are required, it can be saved with only a subset of fields before it’s published. When the event is deleted/remove it should be kept in the database and marked as such.

### Solution

The app was developed as an **API** with **CRUD** rules and **RESTFUL** pattern.

The tricky part was the validations of the model because you have different validations for different states. Anyway, it wasn’t so difficult.

The easy part was the controller because it was just a CRUD controller.

I assumed that the only required field for draft group events is the name. All the other fields are optional for drafts.

### The App

**Requirments:**

- Ruby 2.5.3
- Rails >= 5.2.1.1
- PostgresSQL 10.5

**Run:**

- Clone the app `git clone` 
- Run `bundle` 
- Set database config to reflect yours DB set up
- Run `rails db:create && rails db:migrate`
- Run `rails s`

**How To Use:**

Using a tool as **Postman** or **Insomnia**, it is possible to test the **API**.

**GET** Method we can retrieve all the events or just one specifying the id:

```json
GET http://localhost:3000/api/v1/group_events or /{:id}
{
    "group_event": {
        "id": 1,
        "name": "Test",
        "description": null,
        "status": null,
        "start_date": null,
        "end_date": null,
        "duration": null,
        "latitude": null,
        "longitude": null
    }
}
```

**POST** Method we can add a new event:

```json
POST http://localhost:3000/api/v1/group_events

Body
{
    "group_event": {
        "name": "Test",
        "description": null,
        "status": null,
        "start_date": null,
        "end_date": null,
        "duration": null,
        "latitude": null,
        "longitude": null
    }
}
```

**PUT** Method we are updating one event:

```json
PUT http://localhost:3000/api/v1/group_events/{:id}?{:params}
```

**DESTROY** Method we can delete an event:

```json
DESTROY http://localhost:3000/api/v1/group_events/{:id}
```

### Testing  

The App was tested with **spec** and the results as follow:

```bash
Run options: exclude {:on_refactor=>true}

Randomized with seed 54413

GroupEvent
  callbacks
    when end_date and duration are set but start_date is not
      calculates the start_date
    when start_date and end_date are set but duration is not
      calculates the duration
    when start_date and duration are set but end_date is not
      calculates the end_date
  validations
    should validate that :status cannot be empty/falsy
    when it's a draft
      when name isn't set
        must not be valid
      when only the name is set
        must be valid
    when is published
      when latitude isn't set
        must not be valid
      when start_date and end_date are set but duration is not
        when start_date, end_date and duration are set
          when the values are correct
            must be valid
          when the values are incorrect
            must not be valid
        when start_date is before than end_date
          must be valid
        when start_date is equals to end_date
          must be valid
        when start_date is after than end_date
          must not be valid
      when duration is set but start_date and end_date are not
        must not be valid
      when end_date is set but start_date and duration are not
        must not be valid
      when name isn't set
        must not be valid
      when start_date is set but end_date and duration are not
        must not be valid
      when description isn't set
        must not be valid
      when longitude isn't set
        must not be valid
  destroy
    when the event is destroyed
      must be kepted in the database
    when the event hasn't be destroyed
      must have deleted_at blank

PUT api/v1/group_event/:id
  with invalid params
    should respond with numeric status code 400
    returns an error
  with valid params
    returns group event data updated
    should be successful

DELETE api/v1/group_event/:id
  should be successful
  sets the deleted_at of the group_event

GET api/v1/group_event/:id
  should be successful
  returns group event data

POST api/v1/group_events
  with invalid params
    returns an error
    should respond with numeric status code 400
  with valid params
    should be successful
    returns group event data

GET api/v1/group_events
  when the first page is requested
    returns the first 25 group events
    should be successful
    returns group events data
  when the second page is requested
    should be successful
    returns the last 5 group events

Finished in 1.72 seconds (files took 1.65 seconds to load)
37 examples, 0 failures

Randomized with seed 54413
```

​    



