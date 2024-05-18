GREEN := \033[0;32m
NC := \033[0m
BLUE := \033[0;34m

down:
	@docker-compose -f ./srcs/docker-compose.yml down
up:
	@docker-compose -f ./srcs/docker-compose.yml up -d
status:
	@echo "$(BLUE)[Showing available running containers...].$(NC)"
	@docker ps
	@echo "$(BLUE)[Showing available running images....]$(NC)"
	@docker images
clean:
	@echo "$(GREEN)Stopping and removing containers...$(NC)"
	@docker-compose -f srcs/docker-compose.yml down --volumes --remove-orphans
	@docker volume rm $(docker volume ls -q) || true
	@if [ $$(docker images -q | wc -l) -gt 0 ]; then \
		docker rmi -f $$(docker images -q); \
		echo "$(GREEN)Removing Docker images...$(NC)"; \
	else \
		echo "$(GREEN)No images to remove.$(NC)"; \
	fi
	@if [ $$(docker ps -aq) ]; then \
		docker-compose -f srcs/docker-compose.yml down --volumes --remove-orphans; \
		echo "$(GREEN)Containers stopped and removed.$(NC)"; \
	else \
		echo "$(GREEN)No containers to remove.$(NC)"; \
	fi
	@echo "$(GREEN)Cleanup complete.$(NC)"
fclean: clean prune
	sudo rm -rf /home/clballes/data/wordpress/*
	sudo rm -rf /home/clballes/data/mariadb/*
re: clean all
prune:
	yes | docker system prune -a --volumes

.PHONY: status up down clean
