SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "Turret Deployer (Blue)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "None"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 2
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_turret_b.mdl"
SWEP.WorldModel				= "models/weapons/w_turret_rb.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "slam" )

end

function SWEP:PrimaryAttack()

	self:CreateTurret()
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.00 )

end

--
-- A custom function we added. When you call this the player will fire a chair!
--
function SWEP:CreateTurret()
	
	if SERVER then

		--
		-- Create a prop_physics entity
		--
		local ent = ents.Create( "npc_turret_floor" )

		--
		-- Always make sure that created entities are actually created!
		--
		if (  !IsValid( ent ) ) then return end
 
		--
		-- Set the position to the player's eye position plus 16 units forward.
		-- Set the angles to the player'e eye angles. Then spawn it.
		--
		ent:SetPos(Vector(self.Owner:GetEyeTrace().HitPos.x, self.Owner:GetEyeTrace().HitPos.y, self.Owner:GetPos().z + 10))
		--ent:SetPos(Vector(self.Owner:GetEyeTrace().HitPos.x, self.Owner:GetEyeTrace().HitPos.y, self.Owner:GetForward().z + 10))
		ent:Spawn()

		ent:SetModel( "models/weapons/floor_turret_rb.mdl" )
		ent:SetSkin( 0 )

		ent:SetKeyValue("spawnflags", SF_FLOOR_TURRET_CITIZEN)
		ent:Activate()
	
		ent:SetNWBool("TurretIsFriendly", true)
 
		--
		-- Assuming we're playing in Sandbox mode we want to add this
		-- entity to the cleanup and undo lists. This is done like so.
		--
		cleanup.Add( self.Owner, "props", ent )
 
		undo.Create( "Blue Turret" )
			undo.AddEntity( ent )
			undo.SetPlayer( self.Owner )
		undo.Finish()
	end
end