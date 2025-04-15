# Start from the official Go image
FROM golang:1.20 as builder

# Set working directory
WORKDIR /app

# Copy go.mod and go.sum first (for caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go binary
RUN go build -o gosample

# Final image: use a small Alpine image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/gosample .

# Expose port 8080 (if your app uses it)
EXPOSE 8080

# Run the Go app
CMD ["./gosample"]
