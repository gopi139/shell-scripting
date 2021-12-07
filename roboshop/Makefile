help:
	@grep '####' Makefile | grep -v grep | sed -e 's/####//'

git pull:
	@echo --------- pulling git code -------
	@git pull &>/dev/null

cart     :git pull #### setup cart component
	@bash components/cart.sh

catalogue:git pull #### setup catalogue component
	@bash components/catalogue.sh

shipping :git pull #### setup shipping component
	@bash components/shipping.sh

frontend :git pull #### setup frontend component
	@bash components/frontend.sh

payment  :git pull #### setup payment component
	@bash components/payment.sh

mongodb  :git pull #### setup mongodb component
	@bash components/mongodb.sh

mysql    :git pull #### setup mysql component
	@bash components/mysql.sh

redis    :git pull #### setup redis component
	@bash components/redis.sh

rabbitmq :git pull #### setup rabbitmq component
	@bash components/rabbitmq.sh

user     :git pull #### setup user component
	@bash components/user.sh
