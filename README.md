# GitLocker

### Overview

GitLocker is a marketplace where developers can sell their private repositories hosted on GitHub. It allows users to sync their GitLocker account with GitHub and publish them to the GitLocker marketplace, where the public can purchase the source code.

### Ruby / Rails versions

GitLocker currently runs on ruby 3.3.0 and rails 7.1.3.2. The app's dependencies is constantly being updated via dependabot PRs.

### Database and other notable dependencies

GitLocker runs on PostgreSQL and as far as data storage dependencies go, that's all it needs.

The background job queue runs on `good_job`, which uses postgres as its queue storage. Thus, no other dependencies like redis is required.

### Syncing with GitHub

When the user initial registers, especially as a user that wants to sell their private GitHub repositories, they will be required to sync with GitHub. This means that they will need to:

* have a GitHub account with private repositories ready to go
* and sign in or register with GitHub when authenticating with GitLocker

Once the user syncs their GitLocker account with GitHub, the background job `SyncProductsJob` will be kicked off syncing the GitLocker user account with the GitHub account that the user provided.

In the `SyncProductsJob`, the private repositories of the user will be pulled down from GitHub, and the repositories' name, ssh url, and other information will be synced.

Upon synchronization, the repositories will not be in a published state. The user must go in and edit the price and other information about the repositories and publish them for sale.

Once published, the repositories will be available for sale in the home page for anyone to view and purchase access.
