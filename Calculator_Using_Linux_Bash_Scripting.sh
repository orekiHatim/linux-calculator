#!bin/bash
while true
do  
menu=$(zenity --list --title="Calculatrice arithmetique" --text "Choisir une operation : " --height=400 --width=300 --column "Opertaions" "Addition" "Soustraction" "Multiplication" "Division" "Modulo" "Factoriel" "Cos" "Sin" "Puissance" "Racine" "Logarithme" "Exponentielle")
if [ $? -eq 1 ]; then
	zenity --question --text="Are you sure you wanna exit?" --height=200 --width=200
	if [ $? -eq 0 ]; then
		exit
	fi

else
	if [ $menu = "Addition" ] || [ $menu = "Soustraction" ] || [ $menu = "Multiplication" ] || [ $menu = "Division" ] || [ $menu = "Modulo" ] || [ $menu = "Puissance" ]; then
		while true
		do
		out=$(zenity --forms --title="Operation" --text="Enter two numbers : " --add-entry="First Number : " --add-entry="Second Number : ")
	      if [ $? -eq 0 ]; then
		num1=$(echo "$out" | cut -d'|' -f1,1)
		num2=$(echo "$out" | cut -d'|' -f2,2)
		if [ -z "$num1" ] || [ -z "$num2"  ]; then
			zenity --error --height=200 --width=200 --text="Please fill in the blanks!"
			
		else
			if [[ "$num1" =~ ^-{0,1}[0-9]{1,}$ ]] || [[ "$num1" =~ ^-{0,1}[0-9]{1,}\.[0-9]{1,}$ ]] && [[ "$num2" =~ ^-{0,1}[0-9]{1,}$ ]] || [[ "$num2" =~ ^-{0,1}[0-9]{1,}\.[0-9]{1,}$ ]]; then
				if [ $menu = "Division" ]; then 
					if [ $num2 = 0 ]; then
						zenity --error --height=200 --width=200 --text="Can't divide by 0!"
					else
						res=$(echo "$num1/$num2" | bc -l)
						zenity --info --text="$num1 / $num2 = $res" --height=200 --width=400
					fi
				elif [ $menu = "Addition" ]; then
					res=$(echo "$num1 + $num2" | bc -l)
					zenity --info --text="$num1 + $num2 = $res" --height=200 --width=400
				elif [ $menu = "Soustraction" ]; then
					res=$(echo "$num1 - $num2" | bc -l)
					zenity --info --text="$num1 - $num2 = $res" --height=200 --width=400
				elif [ $menu = "Multiplication" ]; then
					res=$(echo "$num1 * $num2" | bc -l)
					zenity --info --text="$num1 * $num2 = $res" --height=200 --width=400
				elif [ $menu = "Modulo" ]; then
					res=$(echo "$num1 % $num2" | bc -l)
					zenity --info --text="$num1 % $num2 = $res" --height=200 --width=400
				elif [ $menu = "Puissance" ]; then
					res=$(echo "$num1 ^ $num2" | bc -l)
					zenity --info --text="$num1 ^ $num2 = $res" --height=200 --width=400
				fi
			else
				zenity --error --height=200 --width=200 --text="PLease enter a valid input!"
			fi
		fi
	      else
	      break
	      fi
		done
	else
		if [ $menu = "Factoriel" ] || [ $menu = "Racine" ] || [ $menu = "Cos" ] || [ $menu = "Sin" ] || [ $menu = "Logarithme" ] || [ $menu = "Exponentielle" ];then
			while true
			do
			out=$(zenity --forms --title="Operation" --text="Enter a number : " --add-entry="Number : " )
			if [ $? -eq 1 ]; then
				break
			else
				if [ -z "$out" ];then
					zenity --error --height=200 --width=200 --text="Please fill in the blanks!"
				else
					if [ $menu = "Factoriel" ] || [ $menu = "Racine" ]; then
						if [[ "$out" =~ ^[0-9]{1,}$ ]]; then
							if [ $menu = "Factoriel" ];then
								res=$(echo "define f(x) {if (x>1){return x*f(x-1)};return 1} f($out)" | bc -l)
								zenity --info --text="fact($out) = $res" --height=200 --width=400
							else
								res=$(echo "sqrt($out)" | bc -l)
								zenity --info --text="sqrt($out) = $res" --height=200 --width=400
							fi
						else
							zenity --error --height=200 --width=200 --text="PLease enter a valid input!"
						fi
					else
						if [[ "$out" =~ ^-{0,1}[0-9]{1,}$ ]] || [[ "$out" =~ ^-{0,1}[0-9]{1,}\.[0-9]{1,}$ ]]; then
							if [ $menu = "Cos" ];then
								res=$(echo "c($out)" | bc -l)
								zenity --info --text="cos($out) = $res" --height=200 --width=400
							elif [ $menu = "Sin" ];then
								res=$(echo "s($out)" | bc -l)
								zenity --info --text="sin($out) = $res" --height=200 --width=400				
							elif [ $menu = "Logarithme" ];then
								res=$(echo "l($out) / l(10)" | bc -l)
								zenity --info --text="logarithm($out) = $res" --height=200 --width=400		
							elif [ $menu = "Exponentielle" ];then
								res=$(echo "2.71828183 ^ $out" | bc -l)
								zenity --info --text="Exponentielle($out) = $res" --height=200 --width=400			
							
							fi
						else
							zenity --error --height=200 --width=200 --text="PLease enter a valid input!"
						
						fi
					
					fi
				fi
			fi
			done
		else
			zenity --error --height=200 --width=200 --text="PLease choose one of the operations!"
		fi
	fi
	

fi
done

