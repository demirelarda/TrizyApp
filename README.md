

<div align="center">

  <img src="https://github.com/user-attachments/assets/6d08670b-1bfe-49af-b439-ac95bfbad6f7" alt="logo" width="auto" height="auto" />
  <h1>trizy</h1>

  <p>
    A new way to shop!
  </p>


<!-- Badges -->
<p>
  <a href="https://github.com/demirelarda/TrizyApp/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/demirelarda/TrizyApp" alt="contributors" />
  </a>
  <a href="">
    <img src="https://img.shields.io/github/last-commit/demirelarda/TrizyApp" alt="last update" />
  </a>
  <a href="https://github.com/demirelarda/TrizyApp/network/members">
    <img src="https://img.shields.io/github/forks/demirelarda/TrizyApp" alt="forks" />
  </a>
  <a href="https://github.com/demirelarda/TrizyApp/stargazers">
    <img src="https://img.shields.io/github/stars/demirelarda/TrizyApp" alt="stars" />
  </a>
  <a href="https://github.com/demirelarda/TrizyApp/issues/">
    <img src="https://img.shields.io/github/issues/demirelarda/TrizyApp" alt="open issues" />
  </a>
</p>

<h4>
    <a href="https://github.com/demirelarda/TrizyApp/releases/download/v0.1.0/trizy010.apk">Download APK</a>
  <span></span>
    <span> · </span>
    <a href="https://youtu.be/7IuCJMbwbFE">Watch Demo Video</a>
  <span> · </span>
    <a href="https://github.com/demirelarda/TrizyApp/issues/">Report Bug</a>
  <span> · </span>
    <a href="https://github.com/demirelarda/TrizyApp/issues/">Request Feature</a>
  </h4>
</div>

<br />

<!-- Table of Contents -->
# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)
- [Demo](#clapper-demo)
- [Screenshots](#camera-screenshots)
- [Tech Stack](#space_invader-tech-stack)
- [Features](#dart-features)
- [Color Reference](#-color-reference)
- [Getting Started](#getting-started)
    - [Installation](#gear-installation)
    - [Environment Variables](#key-environment-variables)
- [Usage](#eyes-usage)
- [Roadmap](#compass-roadmap)
- [Contributing](#wave-contributing)
- [License](#-license)
- [Contact](#handshake-contact)



<!-- About the Project -->
## :star2: About the Project
Trizy is a modern e-commerce platform that brings personalized shopping experiences to users. With AI powered suggestions, a modern cart system, and a user friendly interface, Trizy allows customers to explore, like, purchase and review products. The platform also includes a unique trial system. It allows users to test products for specific time periods.



## :clapper: Demo

### Download the App
- 📱 [Download APK](https://github.com/demirelarda/TrizyApp/releases/download/v0.1.0/trizy010.apk)

- 🛒 **Purchases:** You can use Stripe test cards to simulate purchases.
  - Example: Use card number `4242 4242 4242 4242` with any future expiration date and any CVC.
  - For more test card details, check Stripe's [test card documentation](https://docs.stripe.com/testing#cards).
  - After making a purchase, your order status will be marked as “pending.” If you are using your own server setup, you can use the admin panel (to be shared soon) to update your order status.
  - If you are not using your own server setup, your order status will automatically update to “delivered” within a maximum of 4 days. (depending on the order delivery date)

### :camera: Screenshots

---

<details>
<summary><b>Auth</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/66961d09-673e-4aaa-9569-8b6b403aba1f" alt="Login Page" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/45f3ba55-8d52-4f2b-99f8-2ff699ec9459" alt="Register Page" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Login Page</b></td>
      <td align="center"><b>Register Page</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Home</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/9e5d7ce6-e59a-451f-9e8d-0b13c54e4c27" alt="Home Page - Deals Section" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/bfa39631-2495-4ce4-919d-4ed26d3a46ee" alt="Home Page - Best of Week Section" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Home Page - Deals Section</b></td>
      <td align="center"><b>Home Page - Best of Week Section</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Search</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/e042c026-f4cb-4b0b-9d12-db99e2e72ec8" alt="Search Page" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Search Page</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Product Feed</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/7abfe1ea-d719-4f0a-aed9-605dbd3346b2" alt="Product Feed" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/83fbd0f0-90e4-4ade-b299-e32e20e0976e" alt="Product Filtering" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Product Feed</b></td>
      <td align="center"><b>Product Filtering</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Product Details</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/1c32ed1b-008b-499a-bd91-66a6d58b6790" alt="Product Details" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Product Details</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Cart Page</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/d9d79cf6-6da8-4db6-9817-d8c6718ce1fb" alt="Empty Cart" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/b9240472-c4b9-49c0-a76d-098acc5d74a2" alt="Cart with Products" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Empty Cart</b></td>
      <td align="center"><b>Cart with Products</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Checkout</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/ccaa774b-68be-4610-b0e7-d5d1d9397282" alt="Checkout Page" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/81dc5a4c-3284-4cb2-881a-924d1de5950a" alt="Payment Page" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Checkout Page</b></td>
      <td align="center"><b>Payment Page</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Address</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/6efce8ad-9bb9-49d4-9705-8a24a5e0fb4a" alt="My Addresses" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/86491b2a-4037-4835-8803-174f9fe5fda2" alt="Create Address" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>My Addresses</b></td>
      <td align="center"><b>Create Address</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Orders</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/ceac3e47-9adb-4ebb-9a2f-60dd5e9e5983" alt="My Orders" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/486e39ce-4269-40ba-80f6-f0be16e841ff" alt="Order Details" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>My Orders</b></td>
      <td align="center"><b>Order Details</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Reviews</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/765c5060-d6fd-4add-a5e4-fe84cea6fdca" alt="Leave a Review" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/f37e2cdf-22aa-4aac-b6e8-fbb800960222" alt="Product Reviews" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Leave a Review</b></td>
      <td align="center"><b>Product Reviews</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>AI Suggestions</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/bb9bc27c-e2b6-439f-897a-abf1d98f898f" alt="AI Suggestions Feed" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/4033247c-3d1a-4414-b741-6aa4bc1e6803" alt="AI Suggestion Details" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>AI Suggestions Feed</b></td>
      <td align="center"><b>AI Suggestion Details</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Subscription</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/8cb15653-40cd-4611-9b94-aa3ae77517c0" alt="Subscription Benefits" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/c8243336-6cbe-4580-a8e7-7cfafc841c1f" alt="Subscription Details" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Subscription Benefits</b></td>
      <td align="center"><b>Subscription Details</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Trial Products</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/4df656fb-d755-4097-a151-8f6650a0832c" alt="Trial Product Feed" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/61861ecb-339a-4370-9dac-fc06344ddd54" alt="Trial Details" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Trial Product Feed</b></td>
      <td align="center"><b>Trial Details</b></td>
    </tr>
  </table>
</div>

</details>

---

<details>
<summary><b>Account</b></summary>

<div align="center">
  <table>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/3700fba4-2fee-4bdf-888e-40c24ffca9ce" alt="Account Page" style="border: 1px solid black; width: 300px;" /></td>
      <td><img src="https://github.com/user-attachments/assets/5aa01f1d-17a3-454d-be73-a01bbad12bea" alt="Liked Products" style="border: 1px solid black; width: 300px;" /></td>
    </tr>
    <tr>
      <td align="center"><b>Account Page</b></td>
      <td align="center"><b>Liked Products</b></td>
    </tr>
  </table>
</div>

</details>

<!-- Features -->
### :dart: Features
- BLoC
- MVVM
- DI
- GoRouter
- Modern UI Design
- Nested Category System
- Optimized Product Search System
- Trial Products
- AI Product Suggestions
- Stripe Payment
- SQLite (Drift) Local Database
- and many more...

<!-- Color Reference -->

<!-- TechStack -->
### :space_invader: Tech Stack

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://flutter.dev/">Flutter</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://nodejs.org/">Node.js</a></li>
    <li><a href="https://expressjs.com/">Express.js</a></li>

  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.mongodb.com/">MongoDB</a></li>
    <li><a href="https://redis.io/">Redis</a></li>
  </ul>
</details>

<details>
<summary>DevOps</summary>
  <ul>
    <li><a href="https://railway.com/">Railway</a></li>
  </ul>
</details>

### 🎨 Color Reference

| Color                | Hex Code  | Preview                                           |
|----------------------|-----------|---------------------------------------------------|
| Primary Color        | `#F34147` | ![Primary Color](https://github.com/user-attachments/assets/f2f29b40-c878-4316-9f1a-5c84ed49f2b9)        |
| Primary Color Darker | `#D8373D` | ![Primary Color Darker](https://github.com/user-attachments/assets/d56c362e-830d-4dfe-838f-cdcbe2f89a66) |
| Secondary Color      | `#FFFFFF` | ![Secondary Color](https://github.com/user-attachments/assets/659cb839-bd75-4b16-9ee0-7ddb983668b4)    |
| Text Color           | `#000000` | ![Text Color](https://github.com/user-attachments/assets/ce356ee9-eac3-4f85-913f-67a4e0320c17)              |


<!-- Prerequisites -->
### :bangbang: Prerequisites
Note: If you want to setup your own server, read below. If you don't, **you can skip** this part.

You need to get the backend from:
`git clone https://github.com/demirelarda/TrizyBackend`

Go to [readme](https://github.com/demirelarda/TrizyBackend/blob/master/README.md) of backend to setup the server:

    https://github.com/demirelarda/TrizyBackend/blob/master/README.md

After setting up the server, you can run it on your local machine or you can deploy it to anywhere. (detailed information in the readme of backend)

Next step is to setup the flutter project.


<!-- Getting Started -->
## Getting Started

First of all, clone the project:

    git clone https://github.com/demirelarda/TrizyApp.git


<!-- Installation -->
### :gear: Installation

Run these in your project folder's terminal:

You need to install the flutter packages:

```bash
flutter pub get
```
Generate files for drift local database:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

<!-- Env Variables -->
### :key: Environment Variables

To run this project, you will need to add the following environment variables to your .env file.

First create a file in the main project folder named: `.env` (same level with your pubspec.yaml)

**If you don't want to setup your own server**, I have the following credentials for you to use:

    STRIPE_PUBLISHABLE_KEY=pk_test_51QYkVh035QmbFUX7DbEHEikKmOetjTaWlDbxdiTtUwr1va85c9YIz3fA0BfnevLrS1odICjXSM29mbfXJyIzeds000ixWNliyz
    BASE_BACKEND_URL=https://trizybackendlive-production.up.railway.app


I strongly recommend using your own server, because if the usage of the above resources' usage exceeds a certain limit, unfortunately, I may have to revoke the credentials I provided.

**If you use your own server**:

In your `.env` file put these:

`STRIPE_PUBLISHABLE_KEY` -> You can get this from Stripe via creating an account and using the test mode, see backend's  [readme](https://github.com/demirelarda/TrizyBackend/blob/master/README.md)  for detailed information about Stripe.

`BASE_BACKEND_URL`  -> Where you deploy the server, just use the URL without any parameters like this: https://example.com (App has the /api/route by default.)

File content should look like that:

    STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key_here
    BASE_BACKEND_URL=your_base_server_url_here



<!-- Usage -->
## :eyes: Usage

You can run the app on any Android device & emulator or iOS simulator.

<!-- Roadmap -->
## :compass: Roadmap

* [ ] Better error handling system
* [ ] Removing boilerplate code
* [ ] Using a networking package
* [ ] Creating a more interactive marketplace


<!-- Contributing -->
## :wave: Contributing

<a href="https://github.com/demirelarda/TrizyApp/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=demirelarda/TrizyApp" />
</a>


Contributions are always welcome!

See `contributing.md` for ways to get started.



<!-- License -->
## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


<!-- Contact -->
## :handshake: Contact

Arda Demirel - [LinkedIn](https://www.linkedin.com/in/demirelarda) - yademirel21@gmail.com