FROM node:12

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed dependencies (--unsafe-perm for postinstall)
RUN npm ci --unsafe-perm

# Build
RUN npm run build

# Build photon.js lib (not needed as it's called in postinstall script)
# RUN npm run prisma:generate

# Make port 80 available to the world outside this container
# EXPOSE 80

# Run `npm start` when the container launches
# CMD ["npm", "start"]