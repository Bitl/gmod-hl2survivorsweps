SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "AR2 Skin 1 (Red)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 2
SWEP.SlotPos				= 7
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_irifle_r_s1.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle_s1.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "ar2" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound( "Weapon_AR2.Single" )
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 13, 1, 0.06 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.085 )

end