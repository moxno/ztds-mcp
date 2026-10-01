# Production Dockerfile for ztds-mcp
# Compatible with Glama.ai, Docker Hub, Cursor, and containerized MCP runtimes
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Copy package specifications
COPY package*.json ./

# Copy application source code
COPY . .

# Set container security & permissions
RUN chown -R node:node /app
USER node

ENV NODE_ENV=production

# Expose standard MCP stdio entrypoint
ENTRYPOINT ["node", "index.js"]
