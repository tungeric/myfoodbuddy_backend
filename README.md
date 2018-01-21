# README
This is the backend for MyFoodBuddy! It is built on Ruby on Rails with a GraphQL server, which is later accessed from the front-end application using the Apollo Client.

## Summary and Structure
The purpose of the application is:

1. To enable users to create foods with specific macronutrients, namely calories, protein, carbs, and fat.

2. To log meals that contain these foods, and track data for each meal and for each day.

On the database level, I created 3 models to accomplish these tasks:
* Food
* Meal
* MealFood

MealFoods is essentially a joins model that contains IDs of the foods and meals that it connects. I created this new table to reduce complexity and increase modularity. I also collected data at the model level for average data per meal and average food data for each meal, along with an "averageness index" for food that tells users what their most average food is. This data isn't fully implemented on the frontend, but the data can be collected in the API.

## GraphQL
GraphQL enables us to get data using queries with a single endpoint as an alternative to RESTful routes. This server is built using Types and Resolvers, which is located in the `app/graphql` folder. The Types include: 
  1. MealType
  2. FoodType
  3. MealFoodType
  4. DateTimeType
  5. MutationType
  6. QueryType

The first three are essentially a reiteration of the model level data, utilizing the relations established between the models to link data points. The DateTimeType is necessary because of the difference between Ruby and JavaScript Times, so this type is created to have a common date/time type.

Mutation and Query Types tell which queries and mutations are written, and each of these are highlighted in Resolvers. The Resolvers are essentially a manifestation of each mutation you will need. The mutations I needed for my application are essentially creating meals, foods, and mealfoods, along with deletion of mealfoods. Also searching for food and meals given user input is written.
