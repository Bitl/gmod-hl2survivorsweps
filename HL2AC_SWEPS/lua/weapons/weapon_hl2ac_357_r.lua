SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= ".357 Magnum (Red)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "357"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 1
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_357_r.mdl"
SWEP.WorldModel				= "models/weapons/w_357.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "revolver" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound("Weapon_357.Single")
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 75, 1, 0.01 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.65 )

end