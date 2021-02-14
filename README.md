# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices. For the group project portion we were given 10 days. For the solo portion of the project adding the "Bulk Discounts" feature I was given 5 days.

## Work Flow Criteria

- Follow MVC Conventions
- Test Driven Development
- Import CSV files to Posgresql Database via Rake Task
- Utilize GitHub Issues, Project Boards and Collaborative Repo Habits
- RESTful Routes

## Completed Functionality

- Admin (non-authenticated)
  - Dashboard
  - Admin Merchants
  - Admin Invoices w/ Access to Items and Invoice Items

- Merchants (non-authenticated)
  - Dashboard
  - Merchant's Items
  - Merchant's Invoices
  
- Bulk Discounts (solo feature added)
  - Adds a Bulk Discounts table to schema
  - CRUD functionality for merchant's discounts
  - Uses Active Record query to add discounts(when applicable) to Merchant and Admin Invoices

## Requirements

- Rails 5.2.x
- PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- Deploy completed code to Heroku

## Catherine, Isabelle and Saundra's Diagram

<img src="https://i.ibb.co/Kq0PyCj/Screen-Shot-2021-01-12-at-6-52-19-PM.png" alt="little-esty-shop">

## Ideas for Additional Functionality

- Authentication for Users and Admin 
- Shopping Cart
