// Remote Store
//============================================================ 
// - Opens a remote general goods merchant.
function	script	F_RemoteStore	{
	cutin "kafra_01",2;
	mes "[Remote Store]";
	mes "Welcome to the Kafra Corporation.";
	close2;
	//callshop "Remote Store",2;
	cutin "",255;
	return;
}
