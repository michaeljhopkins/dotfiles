#!/bin/zsh


function asbclean() {
	asb
	rm -rf .env
	cp .env.example .env
	cd $1
	rm -rf vendor 
	rm -rf node_modules 
	rm -rf bootstrap/cache/*
	rm -rf storage/framework/views*
	rm -rf storage/framework/cache*
	rm -rf storage/framework/sessions*
	rm -rf .env
	rm -rf .env.example
	cp ../.env .env
}

function asbfresh() {
	folders=(Admin Api Customer Olympus)
	asb
	cd Shared
	rm -rf vendor
	composer install
	for i in "${folders[@]}"; do
		asbclean $i
		composer install
		npm install
		bower install
    done
}