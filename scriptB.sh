# process command line arguments
if [ $# -ne 4 ]; then
	echo "Syntax: scriptB.sh number_of_rings tree_height branch_angle branch_factor"
	exit
fi

number_of_rings=$1
tree_height=$2
branch_angle=$3
branch_factor=$4

# generate tree
python my_generater.py $tree_height $branch_angle $branch_factor > a_tree.txt
python rotate_scale_translate.py -x 0 -y 250.0 a_tree.txt > a_tree0.txt
python rotate_scale_translate.py -f 0.2 a_tree0.txt > a_tree1.txt
python rotate_scale_translate.py -x 0 -y -25.0 a_tree1.txt > a_tree2.txt
python lines_to_svg.py a_tree.txt > a_tree.svg

# replicate tree in rings
python rings.py $number_of_rings < a_tree2.txt > a_tree_rings.txt
python lines_to_svg.py a_tree_rings.txt > a_tree_rings.svg

