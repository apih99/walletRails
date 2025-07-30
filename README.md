# Wallet Tracker

A Ruby on Rails application to simulate a wallet and product purchasing system.

---

## Core Technologies

-   **Backend:** Ruby on Rails 7
-   **Database:** PostgreSQL
-   **Authentication:** Devise
-   **Background Jobs:** Sidekiq with Redis
-   **Frontend:** Tailwind CSS
-   **API Client:** HTTParty

---

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

-   Ruby (e.g., v3.1.x) & Bundler
-   Node.js (e.g., v18.x) & Yarn
-   PostgreSQL
-   Redis

---

## Local Setup

Follow these steps to get your local development environment set up and running.

1.  **Clone the repository:**
    ```bash
    git clone <your-repository-url>
    cd wallet_tracker
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    yarn install
    ```

3.  **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Populate products from the API:**
    The `products` table starts empty. To populate it, open a Rails console:
    ```bash
    rails c
    ```
    Then, run the background worker to fetch products:
    ```ruby
    ProductSyncWorker.perform_async
    ```
    You only need to do this once during initial setup. Your Sidekiq process (see next step) must be running for this to work.

---

## Running the Application

This application requires **three** separate processes running in **three** separate terminal tabs.

1.  **Start the Redis server:**
    ```bash
    redis-server
    ```

2.  **Start the Sidekiq worker process:**
    This handles all background jobs, including product syncing.
    ```bash
    bundle exec sidekiq
    ```

3.  **Start the Rails server:**
    This command starts the web server and the Tailwind CSS watcher.
    ```bash
    bin/dev
    ```

You can now access the application at [http://localhost:3000](http://localhost:3000).