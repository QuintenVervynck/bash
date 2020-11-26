#!/bin/bash

# SCRIPT WILL BE RAN AT LOGIN

# startup greeting terminal

# templates from cowsay / cowthink
templates=(
apt                cock               dragon-and-cow     flaming-sheep      kangaroo           mech-and-cow       pony-smaller       stegosaurus        turtle             vader-koala
bud-frogs          cower              duck               fox                kiss               milk               ren                stimpy             tux                www
bunny              daemon             elephant           ghostbusters       koala              moofasa            sheep              suse               unipony
calvin             default            elephant-in-snake  gnu                kosh               moose              skeleton           three-eyes         unipony-smaller
cheese             dragon             eyes               hellokitty         luke-koala         pony               snowman            turkey             vader
)
# pick one
index=$(( RANDOM % ${#templates[@]} ))


clear
fortune | cowthink -f ${templates[${index}]} | lolcat
echo
echo
figlet -t -c "$(date +"%A    %e    %b")"
figlet -t -c "$(date +"%H : %M : %S")"
echo
echo
