# Cabinet File Index Application

This is a simple Ruby on Rails application that stores, sorts and displays digital index cards for use in organizing, cataloging, or studying with flashcards. Unlike physical cards, it combines the simplicity and versatility of index cards with the convenience of a digital format.

---

## Table of Contents
- [Course Objectives](#course-objectives)
- [Project Purpose](#project-purpose)
- [Project Rubric](#project-rubric)
- [Project Description](#project-description)
- [Wireframe](#wireframe)
- [Data Model](#data-model)
- [Entity-Relationship Diagram](#entity-relationship-diagram)
- [Mermaid ERD](#mermaid-erd)
- [Planned Migrations](#planned-migrations)
- [Planned Routes](#planned-routes)

---

## Course Objectives

"In this course, we'll focus on learning the fundamentals of building and working on full stack web applications, including data modeling, application design, API design and the web request cycle. We'll also focus on learning to troubleshoot and debug our code, as well as the fundamentals of automated and manual testing. We'll learn these concepts using Ruby and Ruby on Rails, but the goal is to gain knowledge that is core to full stack web development regardless of language and framework. Then the next web app language and framework you learn will be an easier and faster journey for you. The tools we use as programmers are constantly changing, but the concepts are similar and often build on top of what came before. The ability to learn new languages and frameworks is an essential part of continuing to be a productive programmer. The more exposure and experience we gain with different languages and frameworks, the easier we'll be able to see patterns and analogies in new languages and frameworks we pick up. So don't fret over the question of 'what to learn next' because one of the most important skills you can gain now is learning to learn. Enjoy the journey!"

### Lesson and Course Objectives

- **Design and implement a data model for a small Rails app**
  - Create and update an SQL database using Rails migrations
  - Implement ActiveRecord classes that model the database (including data relationships and constraints)
  - Use Rails console and a SQL GUI to interact with the data model, manipulate data and test a design
- **Design and implement basic CRUD routes for a small Rails app**
  - Use HTTP verbs, query parameters and post data as aligned with standards
  - Respond with statuses and data that align with standards
  - Implement standard authentication and authorization
- **Use Rails conventions when naming migrations, tables, models, routes**
- **Use Ruby to implement CRUD and basic behaviors and functionality beyond CRUD in a Rails app**
- **Design and implement basic API routes for third party consumption**
- **Test a Rails app using automated and manual tests**
  - Design a test plan that encompasses all input scenarios
  - Create unit tests and request tests using Rspec
  - Manually test a Rails app
- **Troubleshoot issues in a Rails and Ruby environments using debugging tools and methods along with knowledge of the framework**
  - Tools:
    - Server logs (dev and test)
    - Debugger
    - Manual testing
    - Browser dev tools
    - Postman
  - Knowledge:
    - Understanding of the web request/response cycle
    - HTTP verbs and how a Rails app responds to requests
    - Understanding of MVC, other parts of Rails app (initializers, environments, Gemfile)
- **Use Rails guides, Ruby docs and gem docs to implement new functionality in a Rails app**

## Project Purpose

This application is the final project for the advanced Ruby on Rails course at Code the Dream, intended to provide hands-on experience applying the knowledge learned throughout the course to an independently designed Rails application.

## Course Objectives
### As Applied to the Final Project
The project you build throughout the course should demonstrate the course objectives (as they apply). Here they are as applied to your project:
- Design and implement a data model using appropriate associations, data types and constraints
  - Demonstrate belongs_to, has_many and has_many :through relationships where it makes sense.
  - Include data constraints at the database level and at the model level where it makes sense. For example, consider what attributes should never be null.
  - Include other validations in models where it makes sense. (presence, inclusion, etc)
- Add behavior to models where appropriate
  - In addition to validations, consider what behavior your models should be responsible for and add any behaviors that make sense.
- Design and implement CRUD-based behaviors for resources where appropriate
  - Create an intentional design that only includes the CRUD functionality that makes sense for each resource.
  - Choose non-resourceful routes when appropriate. Your application should have at least one route (and possibly view) that displays data from multiple models, or that updates multiple models for post and patch/put routes.
- Write rspec tests that cover the most critical functionality
  - Include model specs that test any special behaviors you added. If you've added any custom validations, you can test that as well.
  - Include request specs especially for non-resourceful routes, or any routes with special requirements for parameters, access, etc.

## Project Rubric

Demonstrate the course objectives:

#### Design and implement a data model using appropriate associations, data types and constraints
- [ ] Demonstrate `belongs_to`, `has_many` and `has_many :through` relationships where it makes sense.
- [ ] Include data constraints at the database level and at the model level where it makes sense. For example, consider what attributes should never be null.
- [ ] Include other validations in models where it makes sense. (`presence`, `inclusion`, etc)

#### Add behavior to models where appropriate
- [ ] In addition to validations, consider what behavior your models should be responsible for and add any behaviors that make sense.

#### Design and implement CRUD-based behaviors for resources where appropriate
- [ ] Create an intentional design that only includes the CRUD functionality that makes sense for each resource.
- [ ] Choose non-resourceful routes when appropriate. Your application should have at least one route (and possibly view) that displays data from multiple models, or that updates multiple models for post and patch/put routes.

#### Write rspec tests that cover the most critical functionality
- [ ] Include model specs that test any special behaviors you added. If you've added any custom validations, you can test that as well.
- [ ] Include request specs especially for non-resourceful routes, or any routes with special requirements for parameters, access, etc.

## Project Description

A simple but versatile index card application designed to practice modeling and managing relationships between data in a variety of ways. It is intended for broad use in a similar way as physical index cards, serving countless purposes, such as recipe storage or study flashcards. A user can create individual cards and store information on the front and back of them, can create decks in which the different cards can belong, and can assign those decks to different categories and topics. The user can then use this system to organize and find index cards, view or update them, or use them as flashcards to go through a deck, flipping the cards, and temporarily removing cards from use in the deck as flashcards.

## Wireframe
*tba*

## Data Model
class User < ApplicationRecord; end

users:
- id              integer
- email           string
- password        string
- created_at      datetime
- updated_at      datetime

class Deck < ApplicationRecord
  has_many :card_decks
  has_many :cards, through :card_decks

  has_many :deck_topics
  has_many :topics, through :deck_topics
end

decks:
- id              integer
- title           string
- created_at      datetime
- updated_at      datetime

class CardDeck < ApplicationRecord
  belongs_to :deck
  belongs_to :card
end

card_decks:
- id              integer
- deck_id         integer (foreign key to decks table)
- card_id         integer (foreign key to cards table)
- created_at      datetime
- updated_at      datetime

class Card < ApplicationRecord
  has_many :card_decks
  has_many :decks, through :card_decks
end

cards:
- id              integer
- face_content    text
- back_heading    string
- back_content    text
- created_at      datetime
- updated_at      datetime

class Category < ApplicationRecord
  has_many :topics
end

categories:
- id              integer
- title           string
- created_at      datetime
- updated_at      datetime

class DeckTopic < ApplicationRecord
  belongs_to :deck
  belongs_to :topic
end

deck_topics:
- id              integer
- deck_id         integer (foreign key to decks table)
- topic_id        integer (foreign key to topics table)
- created_at      datetime
- updated_at      datetime

class Topic < ApplicationRecord
  has_many :deck_topics
  has_many :decks, through :deck_topics

  belongs_to :category
end

topics:
- id              integer
- title           string
- category_id     integer (foreign key to categories table)
- created_at      datetime
- updated_at      datetime

## Entity-Relationship Diagram
![Entity relationship diagram for this project](docs/ERD.png)

## Mermaid ERD
```mermaid
erDiagram
  USER {
    integer id PK
    string email
    string password
    datetime created_at
    datetime updated_at
  }

  DECK {
    integer id PK
    string title
    datetime created_at
    datetime updated_at
  }

  CARD_DECK {
    integer id PK
    integer deck_id FK
    integer card_id FK
    datetime created_at
    datetime updated_at
  }

  CARD {
    integer id PK
    text face_content
    string back_heading
    text back_content
    datetime created_at
    datetime updated_at
  }

  CATEGORY {
    integer id PK
    string title
    datetime created_at
    datetime updated_at
  }

  DECK_TOPIC {
    integer id PK
    integer deck_id FK
    integer topic_id FK
    datetime created_at
    datetime updated_at
  }

  TOPIC {
    integer id PK
    string title
    integer category_id FK
    datetime created_at
    datetime updated_at
  }

  DECK ||--o{ CARD_DECK : "has_many"
  CARD ||--o{ CARD_DECK : "has_many"
  DECK ||--o{ DECK_TOPIC : "has_many"
  TOPIC ||--o{ DECK_TOPIC : "has_many"
  CATEGORY ||--o{ TOPIC : "has_many"
  DECK_TOPIC }o--|| DECK : "belongs_to"
  DECK_TOPIC }o--|| TOPIC : "belongs_to"
  CARD_DECK }o--|| DECK : "belongs_to"
  CARD_DECK }o--|| CARD : "belongs_to"
  TOPIC }o--|| CATEGORY : "belongs_to"
```
> **Diagram Attribution:** Generated by GitHub Copilot Chat on September 28, 2025.

## Planned Migrations
1. ~~`bundle exec rails generate migration create_users`~~
2. ~~`bundle exec rails generate migration create_decks`~~
3. ~~`bundle exec rails generate migration create_cards`~~
4. ~~`bundle exec rails generate migration create_categories`~~
5. ~~`bundle exec rails generate migration create_topics`~~
6. ~~`bundle exec rails generate migration create_card_decks`~~
7. ~~`bundle exec rails generate migration create_deck_topics`~~

## Planned Routes
(MVP)

- ~~Dashboard*~~
<br>
- ~~View all categories~~
- ~~View list of category topics~~
<br>
- ~~View form to create new topic~~
- ~~Create a new topic~~
- ~~View the decks of a topic~~
- ~~View form to edit topic~~
- ~~Edit topic~~
- Delete topic
<br>
- View form to create new deck
- Create new deck
- ~~View a list of cards in a deck~~
- View form to edit deck
- Edit deck
- Delete deck
<br>
- View form to create new index card
- Create new index card
- ~~View all cards~~
- ~~View front of card~~
- ~~View back of card~~
- View form to edit index card
- Edit index card
- Delete index card

(* Non-resourceful Route)

---

### Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
