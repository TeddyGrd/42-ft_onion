COMPOSE_FILE = docker-compose.yml
IMAGE_DIR = /home/$(USER)/sgoinfre/docker_images_save

GREEN = \033[0;32m
CYAN = \033[0;36m
NC = \033[0m

.PHONY: all up down re clean fclean build logs restart load-images save-images

all: up

up:
	@echo "$(GREEN)[+] Démarrage des services...$(NC)"
	@docker compose -f $(COMPOSE_FILE) up -d --build
	@echo "$(GREEN)[+] SSH dispo sur$(CYAN) localhost:4242 $(NC)"
	@echo "$(GREEN)[+] Tor hidden service dispo → utilisez cette commande :$(NC)"
	@echo "    docker exec -it tor cat /var/lib/tor/hidden_service/hostname"

down:
	@echo "$(GREEN)[+] Arrêt des services...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down

re: fclean all

clean:
	@echo "$(GREEN)[+] Nettoyage des conteneurs et réseaux inutiles...$(NC)"
	@docker container prune -f 2>/dev/null || true
	@docker image prune -f 2>/dev/null || true
	@docker network prune -f 2>/dev/null || true

fclean: down
	@echo "$(GREEN)[+] Nettoyage complet (conteneurs, volumes, images dangling)...$(NC)"
	@docker volume rm -f 42-ft_onion_tor_data 2>/dev/null || true
	@docker volume prune -f
	@docker container prune -f

build:
	@echo "$(GREEN)[+] Reconstruction des conteneurs...$(NC)"
	@docker compose -f $(COMPOSE_FILE) build

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f --tail=50

restart: down build up

load-images:
	@if [ ! -f "$(IMAGE_DIR)/alpine_3.19.tar" ]; then \
		echo "$(GREEN)[+] Téléchargement des images Docker...$(NC)"; \
		docker pull alpine:3.19; \
	else \
		echo "$(GREEN)[+] Chargement des images depuis $(IMAGE_DIR)...$(NC)"; \
		docker load -i "$(IMAGE_DIR)/alpine_3.19.tar" || true; \
	fi

save-images:
	@mkdir -p $(IMAGE_DIR)
	@echo "$(GREEN)[+] Sauvegarde des images Docker dans $(IMAGE_DIR)...$(NC)"
	@docker save alpine:3.19 -o $(IMAGE_DIR)/alpine_3.19.tar
