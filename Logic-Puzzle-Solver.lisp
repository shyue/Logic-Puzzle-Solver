(setq features '(
		(Blacket Bluet Browning Greenfield Whitehall)
		(Four-Leaf-Clover Penny Rabbit-Foot Ribbon Silver-Dollar)
		(Center First Right Shortstop Third)
))

(setq rules '(
		(Browning Center nil)
		(Browning Right nil)
		(Center Penny nil)
		(Centy Silver-Dollar nil)
		(Right Penny nil)
		(Right Silver-Dollar nil)
		(Browning Penny nil)
		(Browning Silver-Dollar nil)
		
		(Bluet Center nil)
		(Bluet Right nil)

		(Greenfield (Center Right) t)
		(Greenfield First nil)
		(Greenfield Shortstop nil)
		(Greenfield Third nil)
		(Whitehall (First Shortstop Third) t)
		(Whitehall Center nil)
		(Whitehall Right nil)
		(Whitehall First nil)
		(Greenfield Four-Leaf-Clover nil)
		(Whitehall Four-Leaf-Clover nil)
		(Greenfield Penny nil)
		(Whitehall Penny nil)
		(Blacket Four-Leaf-Clover nil)
		(Blacket Penny nil)

		(Blacket Ribbon nil)
		(Bluet Ribbon nil)
		(Blacket First nil)
		(Blacket Third nil)
		(Bluet First nil)
		(Bluet Third nil)

		(Center Rabbit-Foot nil)
))

