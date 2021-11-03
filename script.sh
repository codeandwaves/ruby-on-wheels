#! /bin/sh

# kill nuxt/rails running apps
kill -9 $(lsof -i:5000 -t)
kill -9 $(lsof -i:3000 -t)

cd backend
bin/rails s &
cd ../frontend
yarn dev &