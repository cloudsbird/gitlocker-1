# How to create a GitHub Oauth Application

It is a mini tutorial of how to create OAuth application with github and enable in the code, only created to help developers.

## Step 1: Github

1. Log into the GitHub account which OAuth application will represent
2. Click on the profile picture
3. Go to ``Settings``
4. Go to ``Developer Settings`` on the left bar
5. Select ``OAuth Apps`` and ``New OAuth Apps``

## Step 2: Configure new OAuth App

1. In ``Application name`` choose your application name 
2. In ``Homepage URL`` is the home page complete URL: 
    - dev: ``http://localhost:3000/`` 
    - prod: ``https://yourdomain.com``
3. In ``Authorization callback URL`` is the github callback URL, this case is:  
    - dev: ``http://localhost:3000/users/auth/github/callback`` 
    - prod: ``https://yourdomain.com/users/auth/github/callback``
4. Create the OAuth App and store the ``CLIENT ID`` and ``CLIENT SECRET``

## Step 3: Apply environment var

1. In the development and test environment, copy the ``.env.sample`` file and rename it for `.env` 
2. Update the variable ``GITHUB_CLIENT_ID`` and ``GITHUB_CLIENT_SECRET`` with the new OAuth application created.