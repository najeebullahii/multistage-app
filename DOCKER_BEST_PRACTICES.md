# Multi-Stage Docker Best Practices

## Stage Organization
1. **Base** - Common setup (WORKDIR, COPY package files)
2. **Dependencies** - Install production deps
3. **Build** - Install dev deps, compile/build
4. **Test** - Run tests (optional stage)
5. **Production** - Minimal final image

## Caching Strategy
- Copy dependency files before code
- Separate prod deps from dev deps
- Use --target to build specific stages
- Name stages for clarity

## Security
- Run as non-root user
- Use minimal base images (alpine, distroless)
- Scan for vulnerabilities
- Don't include build tools in production

## Size Optimization
- Multi-stage eliminates build dependencies
- Use .dockerignore aggressively
- Choose smallest base image that works
- Combine RUN commands to reduce layers

## When to Use
- ✅ Compiled languages (Go, Rust, C++, Java)
- ✅ Frontend builds (npm run build)
- ✅ When dev and prod deps differ
- ✅ When you need to run tests in Docker
- ❌ Simple interpreted scripts (may be overkill)
