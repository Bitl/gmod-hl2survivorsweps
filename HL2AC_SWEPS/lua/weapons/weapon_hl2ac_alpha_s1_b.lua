SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "Alpha Stunstick Skin 1 (Blue)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "None"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 0
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_alphaAC_b_s1.mdl"
SWEP.WorldModel				= "models/weapons/w_alphaAC_s1.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "melee" )

end

function SWEP:PrimaryAttack()
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.8 )
	
 	local trace = self.Owner:GetEyeTrace();
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 75 then
			self.Owner:SetAnimation( PLAYER_ATTACK1 );
			self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
				bullet = {}
				bullet.Num    = 1
				bullet.Src    = self.Owner:GetShootPos()
				bullet.Dir    = self.Owner:GetAimVector()
				bullet.Spread = Vector(0, 0, 0)
				bullet.Tracer = 0
				bullet.Force  = 1
				bullet.Damage = 30
			self.Owner:FireBullets(bullet) 
			self.Weapon:EmitSound("Weapon_StunStick.Melee_HitWorld")
	else
		self.Owner:SetAnimation( PLAYER_ATTACK1 );
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER );
		self.Weapon:EmitSound("Weapon_StunStick.Swing")
	end
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.73 )
end