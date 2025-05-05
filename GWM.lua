
function _init()
		pointer = {
		p_x = 64,
		p_y = 64,
		selected = "",
		speed = 8,
		move_cd = 0,
		base_cd = 2
	}
	grid = {
		g_size = 16,
		t_size = 8,
		tiles = {}
	}
	function _init_grid()
		for row = 0, grid.g_size - 1 do
			for col = 0, grid.g_size - 1 do
				local id = col * grid.g_size + row
				add(grid.tiles, {
				t_id = id,
				t_row = row,
				t_col = col,
				floor_type = "grass", -- default
				sp_x = col * grid.t_size,
				ep_x = (col + 1) * grid.t_size,
				sp_y = row * grid.t_size,
				ep_y = (row + 1) * grid.t_size,
				entity_id = "",
				entity_side = "army",
				entity_type = "unit",
				selected = false,
				hovered = false
				})
			end
		end
	end

	_init_grid()
	
function get_tile(id)
		results = {}
		for tile in all(grid.tiles) do
			-- corriger les indices nれたgatifs (prれたventif)
			if tile.t_col < 0 then tile.t_col = 0 end
			if tile.t_row < 0 then tile.t_row = 0 end

			-- dれたtection du curseur sur la tuile
			if pointer.p_x >= tile.sp_x and pointer.p_x <= tile.ep_x and
			   pointer.p_y >= tile.sp_y and pointer.p_y <= tile.ep_y then
				tile.hovered = true
				print('houra')
				if id == nil or tile.t_row == id then
					add(results, {tile.t_id, tile.t_col, tile.t_row})
				end
			else
				tile.hovered = false
			end
			return results
		end
	return nil
	end    
	get_tile()

	--upper_tile = get_tile(t_row)[1][2]-1
end


function _update()
 	if pointer.move_cd > 0 then
 			pointer.move_cd -= 1
		else
		--if btn(0) or btn(1) or btn(2) or btn(3) then
		--	upper_tile
		--else
		if btn(0) then
			pointer.p_x -= pointer.speed
			get_tile()
			pointer.move_cd = pointer.base_cd
		end
		if btn(1) then
			pointer.p_x += pointer.speed 
			get_tile()
			pointer.move_cd = pointer.base_cd
		end
		if btn(2) then
			pointer.p_y -= pointer.speed
			get_tile()
			pointer.move_cd = pointer.base_cd
		end
		if btn(3) then
			pointer.p_y += pointer.speed
			get_tile()
			pointer.move_cd = pointer.base_cd
		end
	end
end

function _draw()
	cls(5)
	--print(get_tile(t_row)[1][2])

	for tiles in all(grid.tiles) do
				if tiles.t_id < 136 then
			spr(016, tiles.sp_x, tiles.sp_y)
		else
  	spr(048, tiles.sp_x, tiles.sp_y)
  end
		if tiles.hovered == true
			do
				print("id: "..tiles.t_id) 												--
				print("col: "..tiles.t_col) 											--dev
				print("row: "..tiles.t_row) 								--
				spr(052, tiles.sp_x, tiles.sp_y) 										--draw bottom
				--spr(036, get_tile(tiles.t_col-1)[1], get_tile(tiles.t_col-1)[2])		--fetch upper tile	
		end
	end
		spr(2, pointer.p_x, pointer.p_y)
		print("pointer x: "..pointer.p_x) 
		print("pointer y: "..pointer.p_y) 
end
