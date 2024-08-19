//
//  FakeData.swift
//  Foodie
//
//  Created by Muhedin Alic on 08.08.24.
//

import Foundation
import Firebase

let sampleUser = User(
    id: "user123",
    fullname: "John Doe",
    email: "johndoe@example.com",
    phoneNumber: "555-123-4567",
    profileImageUrl: "https://example.com/profile.jpg",
    homeLocation: SavedLocation(
        title: "Home",
        address: "123 Main Street, Sample City",
        latitude: 37.7749,
        longitude: -122.4194
    ),
    workLocation: SavedLocation(
        title: "Work",
        address: "456 Corporate Blvd, Sample City",
        latitude: 37.7749,
        longitude: -122.4194
    ),
    isDriver: true,
    coordinates: GeoPoint(latitude: 37.7749, longitude: -122.4194),
    isActive: true
)


let fakeRestaurant = Restaurant(
    id: UUID().uuidString,
    name: "Smokey's Grill House",
    deliveryTime: "30-45 mins",
    restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/smokey-grill.png?alt=media&token=e2795d9d-551d-466c-98f0-8193c160ac11",
    rating: 4.5,
    location: RestaurantLocation(address: "Hadzet 4, Novi Pazar 36300", latitude: 43.1350212, longitude: 20.5092373),
    categories: [.grill, .burgers],
    meals: [
        Meal(id: UUID().uuidString, name: "Classic BBQ Ribs", description: "Tender ribs with our signature BBQ sauce.", imageUrl: "https://img.cdn4dd.com/p/fit=cover,width=1000,height=600,format=auto,quality=50/media/photosV2/d085ca77-268c-4762-83d8-a474fb8ab173-retina-large.JPG", price: Money(amount: 15.99, currency: .USD), category: .grill),
        Meal(id: UUID().uuidString, name: "Grilled Chicken Skewers", description: "Juicy chicken skewers with a smoky flavor.", imageUrl: "https://img.cdn4dd.com/p/fit=cover,width=1000,height=600,format=auto,quality=50/media/photosV2/3c09c6e5-26a3-453e-b08c-a1622d987c56-retina-large.jpg", price: Money(amount: 12.49, currency: .USD), category: .grill),
        Meal(id: UUID().uuidString, name: "Smokey Burger", description: "Burger with smoky BBQ sauce and crispy onions.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/2d6e92a5-6d5d-44a2-b560-9e7872b7ef1f-retina-large.jpg", price: Money(amount: 10.99, currency: .USD), category: .burgers),
        Meal(id: UUID().uuidString, name: "Bacon Cheeseburger", description: "Classic burger topped with crispy bacon and cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/b8246799-523e-49c5-9208-c62bf2eb48af-retina-large-jpeg", price: Money(amount: 11.49, currency: .USD), category: .burgers)
    ]
)

let dbRestaurants = [
    Restaurant(
        id: UUID().uuidString,
        name: "Smokey's Grill House",
        deliveryTime: "30-45 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/smokey-grill.png?alt=media&token=e2795d9d-551d-466c-98f0-8193c160ac11",
        rating: 4.5,
        location: RestaurantLocation(address: "Hadzet 4, Novi Pazar 36300", latitude: 43.1350212, longitude: 20.5092373),
        categories: [.grill, .burgers],
        meals: [
            Meal(id: UUID().uuidString, name: "Classic BBQ Ribs", description: "Tender ribs with our signature BBQ sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/2e35dbe6-6e43-4882-b902-515392d7ebdd-retina-large-jpeg", price: Money(amount: 15.99, currency: .USD), category: .grill),
            Meal(id: UUID().uuidString, name: "Grilled Chicken Skewers", description: "Juicy chicken skewers with a smoky flavor.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/3261e62e-9b10-4a7f-892c-4f34783234b0-retina-large.jpg", price: Money(amount: 12.49, currency: .USD), category: .grill),
            Meal(id: UUID().uuidString, name: "Smokey Burger", description: "Burger with smoky BBQ sauce and crispy onions.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/ugc/662e4361-ca0a-46b1-8a52-43e7fb3420bf.jpg", price: Money(amount: 10.99, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Bacon Cheeseburger", description: "Classic burger topped with crispy bacon and cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/bcb1d149-4318-44a6-9a1c-0777e120221d-retina-large.jpg", price: Money(amount: 11.49, currency: .USD), category: .burgers)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Pasta Paradise",
        deliveryTime: "25-35 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/pasta-paradise.png?alt=media&token=ccd40f4c-33f6-408e-aa68-764b838b81d6",
        rating: 4.7,
        location: RestaurantLocation(address: "Kej 37. sandžačke divizije, Novi Pazar", latitude: 43.1400656, longitude: 20.5126117),
        categories: [.pasta, .international],
        meals: [
            Meal(id: UUID().uuidString, name: "Spaghetti Carbonara", description: "Classic Italian pasta with creamy sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/4adf0537-5b39-4bdb-9ed1-8dfc83bab62f-retina-large.jpg", price: Money(amount: 13.99, currency: .USD), category: .pasta),
            Meal(id: UUID().uuidString, name: "Penne Arrabbiata", description: "Spicy penne pasta with a kick.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/4283ad2b-4313-46ad-b757-f4e9607e2733-retina-large.jpg", price: Money(amount: 11.99, currency: .USD), category: .pasta),
            Meal(id: UUID().uuidString, name: "Lasagna Bolognese", description: "Rich and hearty lasagna with meat sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/eecc791f-2289-484c-a447-b7f29dca4e2d-retina-large.jpg", price: Money(amount: 14.49, currency: .USD), category: .pasta),
            Meal(id: UUID().uuidString, name: "Fettuccine Alfredo", description: "Creamy fettuccine pasta with Parmesan.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/32d6c92d-d89d-401d-a119-02d44e3c4303-retina-large.jpg", price: Money(amount: 12.99, currency: .USD), category: .pasta)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Slice of Heaven Pizza",
        deliveryTime: "20-30 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/heaven-pizza.png?alt=media&token=d696a2af-664a-4262-9d98-fea8f8096a1a",
        rating: 4.3,
        location: RestaurantLocation(address: "Veljka Vlahovića 2a, Novi Pazar", latitude: 43.1347511, longitude: 20.5100271),
        categories: [.pizza, .fastFood],
        meals: [
            Meal(id: UUID().uuidString, name: "Margherita Pizza", description: "Classic pizza with fresh tomatoes, mozzarella, and basil.", imageUrl: "https://glovo.dhmedia.io/image/menus-glovo/products/b1344e8210657e24a9826457f3f8f4dd29b67a598ce80c46fab77fe421dc5f61?t=W3siYXV0byI6eyJxIjoibG93In19LHsicmVzaXplIjp7IndpZHRoIjo2MDB9fV0=", price: Money(amount: 9.99, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "Pepperoni Pizza", description: "Spicy pepperoni with mozzarella cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/856b9df3-aecb-4569-92e9-55e44738c7cd-retina-large.jpg", price: Money(amount: 10.99, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "BBQ Chicken Pizza", description: "Pizza topped with BBQ chicken and red onions.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/25ced615-c06b-4397-895a-2b2ce14d545a-retina-large.jpg", price: Money(amount: 11.99, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "Veggie Delight", description: "Pizza loaded with fresh vegetables.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=1000,height=300,format=auto,quality=80/https://doordash-static.s3.amazonaws.com/media/store/header/fc5d8138-a999-4232-93b0-c3c609a6235f.png", price: Money(amount: 10.49, currency: .USD), category: .pizza)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Burger Barn",
        deliveryTime: "15-25 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/burger-barn.png?alt=media&token=5acaa042-cc98-4408-b48d-899ab9024edc",
        rating: 4.6,
        location: RestaurantLocation(address: "AVNOJ-a, Novi Pazar", latitude: 43.1420635, longitude: 20.5142762),
        categories: [.burgers, .fastFood],
        meals: [
            Meal(id: UUID().uuidString, name: "Classic Cheeseburger", description: "Juicy beef patty with cheddar cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/7b08992e-4495-439f-835e-e6b4d23fce28-retina-large.jpg", price: Money(amount: 8.99, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Double Bacon Burger", description: "Two beef patties with bacon and cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/bcb1d149-4318-44a6-9a1c-0777e120221d-retina-large.jpg", price: Money(amount: 12.49, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Veggie Burger", description: "Grilled veggie patty with lettuce and tomato.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/43fa1ce1-b143-45d7-a92e-4187c7cab748-retina-large.jpg", price: Money(amount: 9.99, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Chicken Burger", description: "Crispy chicken patty with mayo and lettuce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/285ad58a-121b-4e81-b38a-3de93fcc99b0-retina-large.jpg", price: Money(amount: 10.49, currency: .USD), category: .burgers)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "The Sandwich Stop",
        deliveryTime: "10-20 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/sandwich-stop.png?alt=media&token=289aa87c-6068-417e-a5fe-c1faa6e6e873",
        rating: 4.2,
        location: RestaurantLocation(address: "1.maj, Novi Pazar 36300", latitude: 43.1381319, longitude: 20.5159238),
        categories: [.sandwich, .breakfast],
        meals: [
            Meal(id: UUID().uuidString, name: "Turkey Club Sandwich", description: "Triple-layer sandwich with turkey, bacon, and lettuce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/c1b87fed-1bd5-442f-9293-a676533b283c-retina-large.jpg", price: Money(amount: 8.99, currency: .USD), category: .sandwich),
            Meal(id: UUID().uuidString, name: "BLT Sandwich", description: "Classic bacon, lettuce, and tomato sandwich.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/6e0becf9-2628-43bc-8228-10c4e217f56a-retina-large.jpg", price: Money(amount: 7.99, currency: .USD), category: .sandwich),
            Meal(id: UUID().uuidString, name: "Egg & Cheese Sandwich", description: "Breakfast sandwich with egg and melted cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/4729122a-46ef-4930-a275-37354be22d3e-retina-large.JPG", price: Money(amount: 6.49, currency: .USD), category: .breakfast),
            Meal(id: UUID().uuidString, name: "Ham & Cheese Croissant", description: "Flaky croissant filled with ham and cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/277bbfe6-ba62-4ed0-8fda-29cb9b9de337-retina-large.JPG", price: Money(amount: 7.49, currency: .USD), category: .breakfast)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Taco Fiesta",
        deliveryTime: "25-35 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/taco-fiesta.png?alt=media&token=c38aec18-5f89-4c06-ac88-682c21906252",
        rating: 4.4,
        location: RestaurantLocation(address: "Stevana Nemanje, Novi Pazar 36300", latitude: 43.143164, longitude: 20.5183884),
        categories: [.international, .fastFood],
        meals: [
            Meal(id: UUID().uuidString, name: "Chicken Tacos", description: "Soft tacos filled with seasoned chicken.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/bfe00df6-f4bb-4813-bb74-20143b3d89f0-retina-large.jpeg", price: Money(amount: 9.49, currency: .USD), category: .international),
            Meal(id: UUID().uuidString, name: "Beef Burrito", description: "Hearty burrito with ground beef and beans.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/2e936ac4-3c10-4692-8a25-564ebcad6121-retina-large.jpg", price: Money(amount: 8.99, currency: .USD), category: .international),
            Meal(id: UUID().uuidString, name: "Fish Tacos", description: "Tacos with crispy fish and fresh salsa.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/ugc/65eddc34-c989-4a8a-93bf-33d5542ce099.jpg", price: Money(amount: 10.49, currency: .USD), category: .seafood),
            Meal(id: UUID().uuidString, name: "Loaded Nachos", description: "Nachos topped with cheese, jalapenos, and guacamole.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/7720db2d-dd43-4a5b-8fcb-edea72d6ccfd-retina-large.jpg", price: Money(amount: 7.99, currency: .USD), category: .fastFood)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Chicken Delight",
        deliveryTime: "20-30 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/chicken-delight.png?alt=media&token=03a4a7b0-8f81-4873-9d89-2a0611a77ce8",
        rating: 4.8,
        location: RestaurantLocation(address: "28. novembra bb, Novi Pazar 36300", latitude: 43.1425694, longitude: 20.5136975),
        categories: [.chicken, .fastFood],
        meals: [
            Meal(id: UUID().uuidString, name: "Fried Chicken Bucket", description: "A bucket of crispy fried chicken.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/f692b525-66f2-4b91-9153-8406a6f3fc41-retina-large.jpg", price: Money(amount: 14.99, currency: .USD), category: .chicken),
            Meal(id: UUID().uuidString, name: "Grilled Chicken Sandwich", description: "Grilled chicken breast on a toasted bun.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/9c5be0ab-a7f0-451c-a3fc-7508ce0c2fde-retina-large.jpeg", price: Money(amount: 9.49, currency: .USD), category: .chicken),
            Meal(id: UUID().uuidString, name: "Spicy Chicken Wings", description: "Hot and spicy chicken wings.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/331563d8-fe3d-4cf0-83e8-e36553190457-retina-large.jpg", price: Money(amount: 8.99, currency: .USD), category: .chicken),
            Meal(id: UUID().uuidString, name: "Chicken Nuggets", description: "Crispy chicken nuggets with dipping sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/b427fa82-bcfe-4e8a-bd5f-3ff98aafa12d-retina-large.png", price: Money(amount: 7.49, currency: .USD), category: .fastFood)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Fresh Salads",
        deliveryTime: "15-25 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/fresh-salads.png?alt=media&token=1ab504e9-8d80-4cfb-aefa-8a19658eee14",
        rating: 4.5,
        location: RestaurantLocation(address: "28. novembra bb, Novi Pazar 36300", latitude: 43.1424807, longitude: 20.5136916),
        categories: [.salads, .international],
        meals: [
            Meal(id: UUID().uuidString, name: "Caesar Salad", description: "Classic Caesar salad with croutons and Parmesan.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/8ec5e7ba-c583-427d-b8d8-22b53604326f-retina-large.jpg", price: Money(amount: 8.99, currency: .USD), category: .salads),
            Meal(id: UUID().uuidString, name: "Greek Salad", description: "Salad with feta cheese, olives, and cucumbers.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/8a9cca59-2a38-44b7-8e5d-550ffb8f213d-retina-large.JPG", price: Money(amount: 9.49, currency: .USD), category: .salads),
            Meal(id: UUID().uuidString, name: "Caprese Salad", description: "Fresh mozzarella, tomatoes, and basil.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/0c48ec49-81ac-4933-a835-ce66294f9eeb-retina-large.jpg", price: Money(amount: 10.49, currency: .USD), category: .salads),
            Meal(id: UUID().uuidString, name: "Quinoa Salad", description: "Healthy salad with quinoa, avocado, and vegetables.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/abe70297-1323-4af9-8942-dfcb5f52a1c1-retina-large.png", price: Money(amount: 11.49, currency: .USD), category: .salads)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "All-Day Breakfast",
        deliveryTime: "10-20 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/all_day_breakfast.png?alt=media&token=144d8cba-5d78-43ab-9c08-c73ce63f1493",
        rating: 4.3,
        location: RestaurantLocation(address: "Stevana Nemanje 116, Novi Pazar 36300", latitude: 43.1443352, longitude: 20.5169913),
        categories: [.breakfast, .traditional],
        meals: [
            Meal(id: UUID().uuidString, name: "Pancakes with Syrup", description: "Fluffy pancakes served with maple syrup.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/568aced1-1704-409c-a68e-cbb136bd0e67-retina-large-jpeg", price: Money(amount: 7.49, currency: .USD), category: .breakfast),
            Meal(id: UUID().uuidString, name: "Eggs Benedict", description: "Poached eggs on English muffins with hollandaise sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/187411fd-1e4f-48e7-b9aa-d3e671d39ac8-retina-large.JPG", price: Money(amount: 9.99, currency: .USD), category: .breakfast),
            Meal(id: UUID().uuidString, name: "French Toast", description: "Golden French toast with powdered sugar.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/b6006bd1-2cf8-4abe-bfa0-4904134f5acc-b4a1c5d6-7878-475f-b5a8-42603af4f1f0-retina-large.jpg", price: Money(amount: 7.99, currency: .USD), category: .breakfast),
            Meal(id: UUID().uuidString, name: "Breakfast Burrito", description: "Burrito filled with scrambled eggs, cheese, and salsa.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/8f89a12e-fbdc-4a62-9cb3-51325dbc7421-retina-large.JPG", price: Money(amount: 8.49, currency: .USD), category: .breakfast)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Seafood Shack",
        deliveryTime: "30-40 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/seafood-shack.png?alt=media&token=be948b1f-3d47-4258-a481-2c69d107a7d1",
        rating: 4.7,
        location: RestaurantLocation(address: "Kej 12. Srpske brigade BB, Novi Pazar 36300", latitude: 43.1450852, longitude: 20.5211956),
        categories: [.seafood, .international],
        meals: [
            Meal(id: UUID().uuidString, name: "Grilled Salmon", description: "Fresh salmon fillet grilled to perfection.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/c4ecc532-2dfb-46ed-8ecb-5574a136c652-retina-large-jpeg", price: Money(amount: 14.99, currency: .USD), category: .seafood),
            Meal(id: UUID().uuidString, name: "Fish & Chips", description: "Crispy battered fish with fries.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/3df8e202-97f5-4a2b-b39c-61a6bef158d9-retina-large.jpg", price: Money(amount: 12.99, currency: .USD), category: .seafood),
            Meal(id: UUID().uuidString, name: "Shrimp Scampi", description: "Succulent shrimp in garlic butter sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/fd7095d8-ba29-4bf1-b8b7-3b01ac068534-retina-large.jpg", price: Money(amount: 13.49, currency: .USD), category: .seafood),
            Meal(id: UUID().uuidString, name: "Lobster Roll", description: "Fresh lobster meat on a toasted bun.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/ae8b73a7-a733-4875-ae86-eea1ea5217aa-retina-large.jpg", price: Money(amount: 16.99, currency: .USD), category: .seafood)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Steak House",
        deliveryTime: "35-45 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/steak-house.png?alt=media&token=ea98a670-ae85-4d64-a223-b8b3df00dba2",
        rating: 4.9,
        location: RestaurantLocation(address: "4FR4+MF, Ivanča", latitude: 43.141587, longitude: 20.4558677),
        categories: [.grill, .traditional],
        meals: [
            Meal(id: UUID().uuidString, name: "Ribeye Steak", description: "Juicy ribeye steak grilled to order.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/96cb0995-d35b-440d-b9dd-0de616286441-retina-large.JPG", price: Money(amount: 19.99, currency: .USD), category: .grill),
            Meal(id: UUID().uuidString, name: "Filet Mignon", description: "Tender filet mignon with garlic butter.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/084b189f-2c68-4726-96bf-eea12dfc996f-retina-large.jpg", price: Money(amount: 24.99, currency: .USD), category: .grill),
            Meal(id: UUID().uuidString, name: "Grilled Pork Chops", description: "Pork chops grilled with rosemary.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/ff01444e-5955-4a00-bb6d-9927023e0fed-retina-large.jpg", price: Money(amount: 14.99, currency: .USD), category: .grill),
            Meal(id: UUID().uuidString, name: "Prime Rib", description: "Slow-roasted prime rib with au jus.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/72471a15-6229-4a15-92fc-0e635125f893-retina-large.jpg", price: Money(amount: 22.99, currency: .USD), category: .traditional)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Pita Palace",
        deliveryTime: "20-30 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/pita-palace.png?alt=media&token=01fd11f3-72ce-4a03-ae0f-fad26c8f132b",
        rating: 4.4,
        location: RestaurantLocation(address: "28. novembra br. 73, Novi Pazar 36300", latitude: 43.1442426, longitude: 20.5113599),
        categories: [.sandwich, .international],
        meals: [
            Meal(id: UUID().uuidString, name: "Chicken Shawarma", description: "Marinated chicken wrapped in pita bread.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/519f75ec-02b5-4b04-a604-5c0a7ea955a5-retina-large.jpg", price: Money(amount: 9.49, currency: .USD), category: .sandwich),
            Meal(id: UUID().uuidString, name: "Falafel Wrap", description: "Crispy falafel with tahini sauce in pita.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/d2eeadaf-60ff-490b-a8a0-8323b1a787c1-retina-large.png", price: Money(amount: 8.99, currency: .USD), category: .sandwich),
            Meal(id: UUID().uuidString, name: "Beef Gyro", description: "Sliced beef with tzatziki sauce in pita.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/c87b1585-480d-4557-b23b-b1f952ad2091-retina-large.jpg", price: Money(amount: 10.49, currency: .USD), category: .sandwich),
            Meal(id: UUID().uuidString, name: "Mediterranean Salad", description: "Fresh salad with olives, feta, and cucumbers.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/858e342d-2d9a-4740-9224-77382d35fa47-retina-large.PNG", price: Money(amount: 10.99, currency: .USD), category: .salads)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Burger Factory",
        deliveryTime: "15-25 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/burger-factory.png?alt=media&token=04d09126-32f1-45eb-82c7-32638136fb81",
        rating: 4.6,
        location: RestaurantLocation(address: "Jošanički Kej 26, Novi Pazar", latitude: 43.1378723, longitude: 20.5203615),
        categories: [.burgers, .fastFood],
        meals: [
            Meal(id: UUID().uuidString, name: "Factory Burger", description: "Signature burger with special sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/cb7b3159-a091-4584-b58d-139df49f315b-retina-large.png", price: Money(amount: 10.49, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Bacon & Egg Burger", description: "Burger topped with bacon and a fried egg.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/4fbfa49f-941f-4712-8410-fe9db3958e66-retina-large-jpeg", price: Money(amount: 11.49, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Mushroom Swiss Burger", description: "Burger with sautéed mushrooms and Swiss cheese.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/d28cd9c0-549c-4c95-9218-07c1ec7b7865-retina-large.jpeg", price: Money(amount: 10.99, currency: .USD), category: .burgers),
            Meal(id: UUID().uuidString, name: "Chicken Tenders", description: "Crispy chicken tenders with dipping sauce.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photos/9528a943-8833-440c-a88f-1e41b1d68d6b-retina-large.jpg", price: Money(amount: 7.99, currency: .USD), category: .fastFood)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Juice & Smoothies",
        deliveryTime: "10-20 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/juice-smoothies.jpg?alt=media&token=576eaa91-0de6-4539-943f-238e21f0a00c",
        rating: 4.3,
        location: RestaurantLocation(address: "AVNOJ-a BB, Novi Pazar 36300", latitude: 43.1422818, longitude: 20.51647),
        categories: [.drinks, .salads],
        meals: [
            Meal(id: UUID().uuidString, name: "Green Detox Smoothie", description: "Refreshing smoothie with kale, spinach, and green apple.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=1920,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/1ae27055-64b9-474b-b70e-00217bf43aa9-retina-large.jpg", price: Money(amount: 6.99, currency: .USD), category: .drinks),
            Meal(id: UUID().uuidString, name: "Berry Blast Smoothie", description: "Mixed berries blended with yogurt.", imageUrl: "https://img.cdn4dd.com/p/fit=cover,width=1000,height=600,format=auto,quality=50/media/photosV2/a4558dd6-1826-453e-8cd6-1ed90e7d2682-retina-large.jpeg", price: Money(amount: 7.49, currency: .USD), category: .drinks),
            Meal(id: UUID().uuidString, name: "Avocado Smoothie", description: "Creamy smoothie with avocado and honey.", imageUrl: "https://img.cdn4dd.com/cdn-cgi/image/fit=cover,width=800,height=800,format=auto,quality=50/https://doordash-static.s3.amazonaws.com/media/photosV2/9a489bd0-4254-4b20-bf5b-774e7378f6ef-retina-large.JPG", price: Money(amount: 7.99, currency: .USD), category: .drinks),
            Meal(id: UUID().uuidString, name: "Tropical Fruit Salad", description: "Salad with mango, pineapple, and kiwi.", imageUrl: "https://www.meatloafandmelodrama.com/wp-content/uploads/2023/04/tropical-fruit-salad-square.jpeg", price: Money(amount: 8.49, currency: .USD), category: .salads)
        ]
    ),
    Restaurant(
        id: UUID().uuidString,
        name: "Pizza Mania",
        deliveryTime: "20-30 mins",
        restaurantImage: "https://firebasestorage.googleapis.com/v0/b/foodie-3ace8.appspot.com/o/pizza-mania.png?alt=media&token=88acf627-78d2-47c9-a4c1-238a5c054f6e",
        rating: 4.7,
        location: RestaurantLocation(address: "Hala sportova, Generala Živkovića, Novi Pazar", latitude: 43.128689, longitude: 20.5027411),
        categories: [.pizza, .international],
        meals: [
            Meal(id: UUID().uuidString, name: "Four Cheese Pizza", description: "Pizza with mozzarella, cheddar, Parmesan, and blue cheese.", imageUrl: "https://kitchenatics.com/wp-content/uploads/2020/09/Cheese-pizza-1.jpg", price: Money(amount: 11.99, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "Hawaiian Pizza", description: "Pizza with ham and pineapple.", imageUrl: "https://www.shutterstock.com/image-photo/hawaiian-pizza-lifted-slice-2-260nw-84904861.jpg", price: Money(amount: 10.49, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "Meat Lovers Pizza", description: "Pizza loaded with pepperoni, sausage, and bacon.", imageUrl: "https://www.thespruceeats.com/thmb/xuxwh4RIGcZMgaJE8u3SueM0SoA=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/aqIMG_4568fhor-0b89dc5c8c494ee9828ed29805791c5a.jpg", price: Money(amount: 12.49, currency: .USD), category: .pizza),
            Meal(id: UUID().uuidString, name: "Spinach & Ricotta Pizza", description: "Pizza topped with spinach and ricotta cheese.", imageUrl: "https://www.kitchentreaty.com/wp-content/uploads/2014/06/Roasted-Garlic-and-Spinach-White-Pizza.jpg", price: Money(amount: 10.99, currency: .USD), category: .pizza)
        ]
    )
]

// MARK: - Fake order data

// Mock Data for Meals
let sampleMeal1 = Meal(
    id: UUID().uuidString,
    name: "Cheese Pizza",
    description: "A delicious cheese pizza with a crispy crust.",
    imageUrl: "https://example.com/cheese_pizza.jpg",
    price: Money(amount: 8.99, currency: .USD),
    category: .pizza
)

let sampleMeal2 = Meal(
    id: UUID().uuidString,
    name: "Veggie Burger",
    description: "A healthy veggie burger with fresh ingredients.",
    imageUrl: "https://example.com/veggie_burger.jpg",
    price: Money(amount: 7.49, currency: .USD),
    category: .burgers
)

let sampleMeal3 = Meal(
    id: UUID().uuidString,
    name: "Caesar Salad",
    description: "Classic Caesar salad with a creamy dressing.",
    imageUrl: "https://example.com/caesar_salad.jpg",
    price: Money(amount: 6.99, currency: .USD),
    category: .salads
)

// Mock Data for Restaurant
let sampleRestaurant = Restaurant(
    id: UUID().uuidString,
    name: "Sample Restaurant",
    deliveryTime: "20-30 mins",
    restaurantImage: "https://example.com/restaurant.jpg",
    rating: 4.5,
    location: RestaurantLocation(address: "123 Main St, Springfield", latitude: 40.7128, longitude: -74.0060),
    categories: [.pizza, .burgers, .salads],
    meals: [sampleMeal1, sampleMeal2, sampleMeal3]
)

// Creating Order Items
let orderItem1 = OrderItem(
    id: UUID().uuidString,
    meal: sampleMeal1,
    quantity: 2
)

let orderItem2 = OrderItem(
    id: UUID().uuidString,
    meal: sampleMeal2,
    quantity: 1
)

let orderItem3 = OrderItem(
    id: UUID().uuidString,
    meal: sampleMeal3,
    quantity: 3
)

// Creating the Order
let sampleOrder = Order(
    id: UUID().uuidString,
    userId: "sampleUserId",
    items: [orderItem1, orderItem2, orderItem3],
    restaurant: sampleRestaurant
)

// MARK: - Fake checkout

// Sample Data
let sampleRestaurant2 = Restaurant(
    id: "restaurant123",
    name: "Sample Restaurant",
    deliveryTime: "30-45 mins",
    restaurantImage: "https://example.com/restaurant.jpg",
    rating: 4.5,
    location: RestaurantLocation(
        address: "123 Sample Street, Sample City",
        latitude: 37.7749,
        longitude: -122.4194
    ),
    categories: [.pizza, .burgers],
    meals: [
        Meal(
            id: "meal123",
            name: "Sample Pizza",
            description: "A delicious cheese pizza.",
            imageUrl: "https://example.com/pizza.jpg",
            price: Money(amount: 12.99, currency: .USD),
            category: .pizza
        ),
        Meal(
            id: "meal124",
            name: "Sample Burger",
            description: "A juicy beef burger.",
            imageUrl: "https://example.com/burger.jpg",
            price: Money(amount: 8.99, currency: .USD),
            category: .burgers
        )
    ]
)

let sampleOrder2 = Order(
    id: "order123",
    userId: "sampleUserId",
    items: [
        OrderItem(
            id: "orderItem123",
            meal: sampleRestaurant.meals[0],
            quantity: 2
        ),
        OrderItem(
            id: "orderItem124",
            meal: sampleRestaurant.meals[1],
            quantity: 1
        )
    ],
    restaurant: sampleRestaurant
)

let sampleDeliveryLocation = DeliveryLocation(
    address: "456 Sample Avenue, Sample City",
    latitude: 37.7749,
    longitude: -122.4194
)

let sampleCheckout = Checkout(
    id: "checkout123",
    order: sampleOrder2,
    restaurant: sampleRestaurant2,
    requestUtensils: true,
    deliveryLocation: sampleDeliveryLocation,
    deliveryInstructions: "Leave at the front door.",
    appointedDeliverer: nil,
    status: .CREATED,
    contactPhoneNumber: "555-123-4567",
    timestamp: Date()
)

// This sampleCheckout object can now be used as a fake data model for testing.

