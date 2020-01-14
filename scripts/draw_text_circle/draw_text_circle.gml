/// @description draw_text_circle(x,y,str,radius,charangle,firstchardir, arc*, centered*)
/// @param x
/// @param y
/// @param str
/// @param radius
/// @param charangle
/// @param firstchardir
/// @param arc* - how far around the circle
/// @param centered* - if the text should be cenetered on the input direction rather than starting from
///Created by Andrew McCluskey (nalgames.com)

originx=argument[0]; //Where you want the centre of the circle to be (x coordinate)
originy=argument[1]; //Where you want the centre of the circle to be (y coordinate)

radius=argument[3]; //How far from the central point you want the text to be drawn

facing=90+argument[4]; //Whether you want the text to face outwards (90) or inwards (270)

initdir=argument[5]; //The initial direction of the first character in the text string

msg=argument[2]; //What you want the circle text to say. Leave a space at the end of the string for clarity.

if (argument_count > 6) {
	arc = argument[6]	
	if (argument_count > 7) {
		if (argument[7]) { //if centered
			//change initdir
			initdir += arc*(0.5 + 1/(string_length(msg)))
		}
	}
} else {
	arc = 360	
}

//Do not alter anything past this point.

draw_set_halign(fa_center);
draw_set_valign(fa_center);

s=string_length(msg)

for(i=1;i<=s;i+=1)
{
    draw_text_transformed(originx-lengthdir_x(radius,((i/s)*arc)+initdir)+2,originy+lengthdir_y(radius,((i/s)*arc)+initdir)+2,string_hash_to_newline(string_copy(msg,i,1)),1,1,((-i/s)*arc)-facing-initdir);
}
