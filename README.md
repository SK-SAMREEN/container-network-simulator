# Container Network Simulator

## Project Overview
This project demonstrates how Docker containers communicate with each other using Docker networks and how network isolation works.

The goal is to understand Docker networking practically, not just theoretically.

---

## What This Project Demonstrates
- Communication between containers in the same Docker network
- Isolation between containers in different Docker networks
- Difference between ICMP (ping) and TCP (HTTP) traffic
- Docker internal DNS resolution
- Basic Bash automation for network testing

---

##Technologies Used
- Docker
- Linux (Alpine)
- Bash scripting
- Docker Networking (Bridge networks)

---

## Network Architecture
- **bridge_network**: Allows container-to-container communication
- **isolated_network**: Prevents communication with other networks

---

## Containers Used
| Container | Network | Purpose |
|--------|--------|--------|
| c1 | bridge_network | Client container |
| c2 | bridge_network | Server container |
| c3 | isolated_network | Isolated container |

---

## Tests Performed

###1 Ping Test (ICMP)
- `c1 → c2` ✅ Success
- `c1 → c3` ❌ Failed (expected)

### 2 HTTP Test (TCP)
- Web server started in `c2` on port `8080`
- Accessed from `c1` using `wget`
- Response received (404 or content confirms connectivity)

---

## Bash Automation
A Bash script was used to automate ping tests and log the results.

---

## Key Learnings
- Containers can communicate only within the same Docker network
- Docker provides built-in DNS for container name resolution
- Network isolation improves security
- Ping checks connectivity, HTTP checks real application traffic

---

## How to Run This Project

```bash
# Create networks
docker network create bridge_network
docker network create isolated_network

# Create containers
docker run -dit --name c1 --network bridge_network alpine
docker run -dit --name c2 --network bridge_network alpine
docker run -dit --name c3 --network isolated_network alpine

# Test connectivity
docker exec c1 ping -c 3 c2
docker exec c1 ping -c 3 c3
