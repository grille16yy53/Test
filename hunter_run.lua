--[[
	HUNTER (Half-Life 2) - Plane Crazy SmallPart build - v1  (1400 SmallParts, rebuilt 1:1 from hl2_hunter_rig.glb)
	===== SHARED FIGURE DEFINITION =====
	IDENTICAL in script 1 (paint) and script 2 (run). Replace everything down to and including "-- ===== END SHARED =====" in BOTH.
	The figure is baked data: 1400 oriented plates fitted to the real mesh (skin + armor), colours sampled from the textures,
	grouped on the 48 bones of the original rig. SCALE = studs per model inch (0.4 -> ~42 studs tall).
	Model: "HL2 Hunter Rig" by NO DONT EAT ME CASEOH (Sketchfab), CC-BY-4.0.
]]
local SCALE = 0.4
local MAX_PARTS = 1400

local V3 = Vector3.new
local CFn = CFrame.new
local Ang = CFrame.Angles

-- model space: inches, Y up, the Hunter faces +Z. FRONT turns +Z into Roblox forward (-Z).
local FRONT = Ang(0, math.pi, 0)
local BONE_NAME = {
	"body_joint_01",
	"bck_clav_bone_02",
	"bck_leg1_bone_03",
	"bck_leg2_bone_04",
	"bck_leg3_jnt_05",
	"bck_foot_bone_06",
	"bck_toe_07",
	"bck_claw_08",
	"antennaBase_010",
	"antennaRaise_011",
	"antennaSpike1_012",
	"antennaSpike2_013",
	"top_stalk_bone_014",
	"top_eye_bone_015",
	"topEyeClose_016",
	"l_mandible1_017",
	"l_mandible2_018",
	"low_stalk_bone_019",
	"low_eye_bone_020",
	"bottomEyeClose_021",
	"r_mandible1_022",
	"r_mandible2_023",
	"l_clav_024",
	"l_leg1_bone_025",
	"l_leg2_bone_026",
	"l_leg3_bone_027",
	"l_foot_bone_028",
	"l_toe_029",
	"l_claw_030",
	"r_claw1_031",
	"r_claw2_032",
	"r_claw5_033",
	"r_claw4_034",
	"r_clav_bone_035",
	"r_leg1_bone_036",
	"r_leg2_bone_037",
	"r_leg3_bone_038",
	"r_foot_bone_039",
	"r_toe_040",
	"r_claw_041",
	"l_claw1_043",
	"l_claw2_044",
	"l_claw3_045",
	"l_claw4_046",
	"l_antenna1_047",
	"l_antenna2_048",
	"r_antenna1_049",
	"r_antenna2_050"
}
local BONE_PARENT = { 0, 1, 2, 3, 4, 5, 6, 7, 1, 9, 10, 10, 1, 13, 14, 1, 16, 1, 18, 19, 1, 21, 1, 23, 24, 25, 26, 27, 28, 1, 30, 31, 32, 1, 34, 35, 36, 37, 38, 39, 1, 41, 42, 43, 1, 45, 1, 47 }  -- 1-based index, 0 = root
local BONE_T = {  -- rest translation of every bone in its parent frame (inches)
	{ 1.5527, 73.9375, 14.4453 },
	{ -0.0000, -0.8204, -10.2122 },
	{ 8.1884, 0.0008, 0.0000 },
	{ 18.6183, -0.0000, -0.0000 },
	{ 17.3827, -0.0000, -0.0000 },
	{ 39.0000, -0.0018, 0.0000 },
	{ 13.2744, -2.0063, -0.3758 },
	{ 3.3469, -1.7021, 0.0855 },
	{ 10.7639, 3.6646, -9.9777 },
	{ 0.0000, 5.2128, -4.2706 },
	{ -0.3340, 14.1612, -0.5180 },
	{ 0.1749, 12.0915, -0.5503 },
	{ 0.0000, 3.7988, 7.6523 },
	{ 2.0957, 0.4321, 0.0000 },
	{ 4.9596, -0.0000, -0.0000 },
	{ 8.6586, -12.0971, 4.2890 },
	{ 13.5710, -0.0000, -0.0000 },
	{ 0.0000, -7.4492, 10.0312 },
	{ 2.0000, 0.7695, 0.0000 },
	{ 4.9596, 0.0000, -0.0000 },
	{ -8.6586, -12.0971, 4.2890 },
	{ 13.5710, 0.0000, -0.0000 },
	{ 11.8549, 0.1009, 2.9823 },
	{ 8.3224, 0.0000, -0.0000 },
	{ 19.0991, -0.0000, -0.0000 },
	{ 17.9339, 0.0000, 0.0000 },
	{ 37.0000, 0.0000, 0.0000 },
	{ 13.9375, 1.0879, 0.4021 },
	{ 2.8831, 1.6989, 0.0246 },
	{ -3.0344, -12.5286, 11.7759 },
	{ 4.1476, -0.0000, 0.0000 },
	{ 11.6534, 0.0000, 0.0000 },
	{ 12.4450, 0.0000, 0.0000 },
	{ -11.8549, 0.1009, 2.9823 },
	{ 8.3224, -0.0000, 0.0000 },
	{ 19.0991, -0.0000, 0.0000 },
	{ 17.9339, 0.0000, 0.0000 },
	{ 37.0625, -0.0000, -0.0000 },
	{ 12.2671, 1.6172, 0.0335 },
	{ 4.9124, 1.4933, 0.0460 },
	{ 3.0344, -12.5286, 11.7759 },
	{ 4.1476, -0.0000, -0.0000 },
	{ 11.6534, 0.0000, -0.0000 },
	{ 12.4450, 0.0000, 0.0000 },
	{ 1.2687, -14.1289, 8.6198 },
	{ 6.9240, 0.0000, -0.0000 },
	{ -1.2917, -14.1289, 8.6198 },
	{ 6.9240, 0.0000, 0.0000 }
}
local COUNTS = { 264, 2, 76, 51, 69, 33, 8, 12, 14, 45, 2, 2, 48, 41, 3, 18, 5, 36, 40, 3, 19, 5, 17, 65, 49, 68, 33, 7, 13, 5, 15, 13, 9, 12, 68, 51, 68, 28, 15, 12, 6, 14, 13, 9, 6, 2, 4, 2 }
local PAL = { "33322e", "535f5d", "3a403a", "647070", "6d7c7b", "596968", "3f3f3f", "555046", "191919", "5e6e6c", "2e2d26", "676557", "3a3a33", "414235", "697877", "363c3a", "333933", "4f5b61", "5c574d", "4b5b56", "3a362e", "3f4a4b", "849392", "4f5a5a", "4a4a41", "464a36", "41403a", "4b5656", "566161", "333633", "526261", "333426", "514b46", "46453f", "464646", "3a3c3a", "434b4f", "676155", "51523f", "635d51", "353936", "58574b", "40443f", "36362e", "636051", "343329", "3a3e36", "3e4344", "3a3f3f", "555246", "3d3f2e", "46453a", "2e3333", "46423d", "6d6c5c", "33342e", "333433", "4a463f", "464636", "526161", "353633", "3a3a3a", "363e3a", "4a4a3a", "525c5c", "605c51", "6b6656", "647372", "41443a", "333936", "566264", "2e2c2e", "33393a", "363c36", "3d3a2e", "36372e", "515149", "687776", "363a36", "4a4641", "3f454b", "292821", "2e332e", "465152", "363932", "3a3a2e", "3f4035", "333333", "3b4043", "35332e", "626055", "333636", "333434", "6b7979", "3f3929", "525f61", "616b6b", "332f2e", "3a3930", "2a242a", "5c5c44", "4d5246", "4a4b4a", "363f3f", "677573", "3a4141", "3f4b46", "484741", "4d4b46", "36342e", "525440", "4a4b46", "3f403a", "3a3b36", "3f443a", "4b5759", "5b6162", "4b595a", "3a413a", "3a3933", "5c6766", "514b41", "3a3f3a", "35393a", "4d4d41", "5b6969", "363a3a", "4b5255", "41413e", "414640", "464633", "3f4648", "343432", "515046", "605c4d", "6d7b7a", "666258", "3f4946", "3f4547", "343434", "575746", "676151", "4d4b41", "4c4b3a", "41412e", "514d3a", "3d3c33", "3f3f3a", "5a5751", "191b19", "515146", "586564", "5c6465", "514d46", "585c46", "6d685c", "4d4d46", "364041", "4d4b44", "514d3f", "363938", "4f5c5c", "3b4346", "5c5a51", "3a403f", "3f3f3c", "5c5b4d", "55554b", "5c6a6a", "3f4b4f", "3a3a30", "36392e", "3a3c33", "677575", "34342e", "3f403f", "464b46", "44403a", "585346", "4f5f61", "434f4f", "464641", "515141", "657473", "606f6e", "555146", "4a4a36", "556564", "464a3a", "3a3c2e", "363934", "2e2f2e", "2e3636", "2e2821", "3f474b", "46504f", "333735", "33362e", "363635", "464a3f" }
local DATA = table.concat({
"iZeOjQplJPZKhAWbrhhemwtKJuaQA4jDkdextrMMjnHAAj1g0cUrmKSGMRC/ezlNhnupJOIxeA+cRfDeyujLGbmpAefwbpg2sWJaMUfBXfAb0fVmhLN/gvAeguiZcZqiJNFXDAed2k8hXxnJawYQAPh9cUe00iJbgoRAVdqc8i7pkJd4fAB1g9emdAqXJTLeiAeiki+jSwnJLt4vAdhTldgBwsJR4OrAob9gdeSrnMNCQJC7jBf3i8ruLOxWeBOcmcWf6ulKeoU6DEcGi+hUwuJRY5YBUewjbjprmLE6XKA3jyeyfSriJVygMArd0gijO0fNIiofBYdUkTiZrnKUHUmA4hsfSdDpRJHpc/BTjWcMhakiOG9AhAAfFdrdgtlJLtm6BffzcCj3soSU4HRChhwkkijysJZpeKA+c/c5ewyqLaGZNA4kiiEfS1xMM2ICBbeWkFc3usJdXKRBFitkphi0mKWXMcAoeChIcqrpLPFtHCVkHjvhXtsJEAY9APiElDfJwuJUUTnAPhJbwjGdKJSqOvAeczfYc7oiJb29YADfxlgf3wsLMT9DA8fgixcL0tJPJdNAig6efcVvnJGRcLAefwcTefsWJbM0MAeemfLcvnfJJ+mGBTeicHgkqkJJYeYAecpkkhevvJECP2APjceqgF1PJIgu8Aej0iuh0ynJFUghBxeFlFfArsJdHmPB7cVejgt1mJLkqRBGikb3gOykNWTMlC/hck8eEuuJL3hNBFc6klfLyqJO/AUAdg6b2fOojUPNRuAekjjSfFwtLQ1vFBbhuhycfrnJVGOXBfcQdVfPsjJKKsJA4c2d8hOtnJL1AIAefxbzfjvZJaQWfAIb1jAeY0sJO5gfA+iEhWjDjdJR8zjATcucjhcrZKcgsPAdhWeMdcopJEWHQAecXe6f5tlJNkukA7eBcUeytnLIx0WChdWejjEtqKRl3MA7kLkTfXypKGrasB+hhcHgyroJV/sjBGjweac+rkJPBxgBFeZkmikrrJE6JoA+hTkPc0zsJHbMsAdivbohKplPL/9KBScJj9h1zpJRR9VBOgObxisujLFrYfAedHgmi/1tJR9ZmAreGeRjyrmKcpIQA7gybwhswhJNSwFBGdyikjcwtJL99MA3eIe0c+qnJTm+KABkYgfdMpnJZ0hrA0fNhVbtpkJfaFmBYj3kmgtyoJVvqvCkhfclejvfNG9BMB1bpj9gtvrJQ6K4BUi/e5cjskJbWdxBbeTcVjhkcJeVGsAVe5eddGpiLEBfgA7fVbsitteMd0NQAeh4dgjyrjJG9IsAehbfrcvvZJdwoPAehxi8cNwkQcpcXAdiReDdhrVJGYi4BxkBfqeerhJWF8LArgRcVeblWJWSWLAeiDcQiW0kJMycKAekKiXeQ2tJSBfiB7dPhujE1rNcpIuAAcVg3ii2eJP6DKAedUcKfrthKaQyQA8jEd6hRwkJMXGKAehbjkjjxwJa6dBC/eTb/hwsXJaIgdAefYj1cGytJdyenBbdQdTh7ndJewi8AeiTjmc9sqNSU/dA4jOg4iyxmLPZWkBOhygdcxqTJHlW0CziVfEc1oYJHA0vAMchcsgmnoLRbQYAAfEcCezsjPKJkpAeeUcBfqkeMetFmA7b8fze5toJRZFlAvkDdgf8yhJGIw3AAkNhDfIzvJbIK1AehLb2iqplMNUTWAXb6kOfK3kJWlRmAweLf+czqYJPN5FBjdNd3ilqkKQ9RRAehUdRd3viLMRFGA7jZd8gHsfJJFQqArbYhrf6qkLLqkKAocheRfEujJbcOcA8eugmb0pjJGpCOAecqgqdTpeJNKqcABijg9jVtXJHxgzBUhFi8jauqMLXHdBRgRb3fPhXJXO0dAegIbkhxndNNcLSAedEdHhKvVJPFFdA8gllIh1zoJM0fMB+g6hDbmjWJNzDYAebYicfTtoJOA4OB7dajadEvpJN6EUAdf9bujItgZKr25Aee3cChspZJRIiiAecDfdd7nlJMFgPB0dSgQculfJJGfDCXgnkbi8wsJOY5RA8fnb/jxijJNTKXChiWlAgcwuJEnQMAPcGh2iAofJbI6LAejDixdYzwJdJUVAdd2eGdlojRaCtUA7dsiacgwrJPZYmAdbpgzfjwqKL1WRAebqiBhFxaJMcjjC0fok1ibvtJZpSTAod2dajhrmJc1CuBfgTbugIfZJXS4eARjkkTh2ugJWW4jB6kZfgd1skJFkQnAAhpb/frurLM3s7BGhnb9h4qhJGwfeAecWf6dUniJDExDAJfNkNjNwxJUDG0AdhtlJhXxrJY1aPA+i8eqiowkKOZ2aDCdYk4gXwrJDtEFAdgljVb/zgQLttBBUd1cViJpfJSYdsAeiih5c34vJaNJ3Crg+hJcFpUJVHviAeh3exjrrcKHlOmCJdAeedvsXJOTk5AFdTeqc7onJG5FNC3gnhvcdsZJNK5OAekDfgcrsqKRh/bBFd+fTjeykbNWPdAee5encQjgJGPq0A7jYcMferfJaoqNBSgKd4dTunONhDTA7chikiYvoKRdVbAdhpcfjpxmJOOOXAXdcbsg/zjOaYgVAdihdHiLmjJFc4QAXjNf/cJsqLbZ0DA4gUkNceyqJN7QyDEeYjRcKsmJcSotDEc7jZi5wmJR+BgArjejbihwnJGE02C+eocfecrWJRaBrA7fLkrdX1rJVo3gAPcxb5hEzjKdgLSA4jpdgdvtoJJk69BIkjj7gQxoJNFaMB+gycjeXrbJb8qQA7esiKcXwxJMhdOB1iSdGjEqjJGRCUA7iLfTjVneSPts+Aej9cufzrkJMSyGA0c1d1eYtnNChRIAAhTfRcFljJRjWRAeipcdfGqeJWyiOAdfUbuharbJdoNOAIglldg3tsJSPlbAPidgJcbmbJHVCvA8b9fzf2pkJI+iTAefQlQery3JLXjLAdgJeCcZjeJRw0MAekPdueMnpJawdCBIkZeYe3xhJKGWJBhj0f4fUxkJKjgPAeeIcOi7mfJbIbzCKiQiPjaxiJOF60A4iPgTjGpfKR/ETCzjmhddJ0pKVPpIA3emfeb/rdJJLERA7cpdggKqpJOBvqA8c6fbiyuwPLyLZBVkUizgY1tJD0oyBOkBgsd5ogJWGEIAretb1ivnmOJccdAefRb1gPocJKVaEAQjKkvgAusJY7RlAPjGhecrtfJVMtOA3kReodnvmJQeBHBIefcwkBueKOO1YAVikdHeKpmJGs3TBFgCdId1rjLMRNDAegQk3dpxpJVsvnBbdGhtdIvrJNpeaAAi1d2iTsiJEgmsAVgFjLjftwJexTlBKeOh1i+sUJJbgoAefllbg/vpJOEVTB7hUgScAliJbsRNAefehzcWmZJLq8vCigFhlbqoiMSUujAedsfgcngeJclmXCXbXjnfjwpJNhmEB+cShrd3tnJPpQsAdhkg/corkSN+LHAefAiwjJpWJKXi6Aef0bpidpdKM+uFAegolWe70pJKbjOAdgFj1jpxoJLxA9BhjkjoeJ4tJLyvaBbeilZgF2wJNfgUA+cle5dvqoOLRCPAchkiMi/jVJOHbXAIbmiugTuqJSA/tAoizg4cPpeJMeisA3jeczedtrJUTWjBFfHc2eCogKO8tGAbgRbnhBhXJFjsbAejQiCiuvtJFY6vBJd+kpeAztJe6ZVB7ewhJccncJGxciA7eEdUeAssJWCEQBfcxj5eFyuJeOJkAdkOdOe9nkJZUpODAcketiKtpJDfAbAeijj/izvpJKdMoAdjuhjd74kJNV9dBOdTcJhmqlJbKWLAKfceIcjtbLdcdjAectiwdjtrJC9HAAdd6jxjKspJFiPbAAg0b2gVvgJNC4GBGjRdIg63uNVjHEBUi4d6dQsiJJBUmBbjicHgfsnMYo3SA0efgLcXkhJA85rA7cHkngb1uJODaQA+ibkPd0xwJelimBSiscRhlwkLTeYHAt",
"hUe8fF8PJdrnhAchUgpey6JJIZXfAe",
"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",
"f+gfgDaEJRbUSBngBgegEgIJI3IaCd",
"gDgdgDdKJHpUsBngBhcgCkGJP5/BBI",
"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",
"hufygKxKJEx8yAeghf0gIqIJUTJNAe",
"haf8gNySJECA+Aehaf2f/xRJD6FtAbhsgGf/dQJfB89A7g8f/gBaVPE2IxAe",
"gif0gDtJJM63CAehxf0f+vJJLKM8Ae"
})

local ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local MAP = {}
for i = 1, 64 do MAP[ALPHA:byte(i)] = i - 1 end
-- smallest-three quaternion: 2 bits (dropped component) + 3 components of B bits each
local function unpackQ(qb, B)
	local S = 2 ^ B
	local m = math.floor(qb / S ^ 3) % 4
	local k = S - 1
	local c = {
		(math.floor(qb / S ^ 2) % S) / k * 1.4144 - 0.7072,
		(math.floor(qb / S) % S) / k * 1.4144 - 0.7072,
		(qb % S) / k * 1.4144 - 0.7072,
	}
	local qq, ii = { 0, 0, 0, 0 }, 1
	for t = 1, 4 do
		if t - 1 ~= m then qq[t] = c[ii] ii = ii + 1 end
	end
	local s2 = qq[1] ^ 2 + qq[2] ^ 2 + qq[3] ^ 2 + qq[4] ^ 2
	qq[m + 1] = math.sqrt(math.max(0, 1 - s2))
	return qq
end
local function newReader(str)
	local pos = 1
	local function rd(n)
		local v = 0
		for _ = 1, n do v = v * 64 + MAP[str:byte(pos)] pos = pos + 1 end
		return v
	end
	local function ch() local c = str:sub(pos, pos) pos = pos + 1 return c end
	return rd, ch
end
local function clampN(v, a, b) return math.max(a, math.min(b, v)) end

local palc = {}
for i, h in ipairs(PAL) do
	local n = tonumber(h, 16)
	palc[i - 1] = { math.floor(n / 65536), math.floor(n / 256) % 256, n % 256 }
end

-- BOXES[i] = { bone = index, cf = bone-local CFrame (studs), size = Vector3 (studs), color ... }
local BOXES = {}
do
	local rd = newReader(DATA)
	for bi = 1, #BONE_NAME do
		for _ = 1, COUNTS[bi] do
			local x, y, z = (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05
			local sx, sy, sz = rd(1) * 0.1, rd(1) * 0.1, rd(1) * 0.1
			local q = unpackQ(rd(4), 7)
			local c = palc[rd(2)]
			BOXES[#BOXES + 1] = {
				bone = bi,
				cf = CFn(x * SCALE, y * SCALE, z * SCALE, q[1], q[2], q[3], q[4]),
				size = V3(clampN(sx * SCALE, 0.1, 2.5), clampN(sy * SCALE, 0.1, 2.5), clampN(sz * SCALE, 0.1, 2.5)),
				r = c[1], g = c[2], b = c[3],
			}
		end
	end
end
local function gridOf(studs) return math.clamp(studs / 2.5, 0.04, 1) end
local function q100(v) return math.floor(v * 100 + 0.5) end
for _, b in ipairs(BOXES) do
	b.gx, b.gy, b.gz = gridOf(b.size.X), gridOf(b.size.Y), gridOf(b.size.Z)
	b.color = Color3.fromRGB(b.r, b.g, b.b)
	b.key = q100(b.gx) .. "," .. q100(b.gy) .. "," .. q100(b.gz) .. "|" .. b.r .. "," .. b.g .. "," .. b.b
end
print(("[Hunter] SCALE %.2f -> %d SmallParts needed (cap %d)"):format(SCALE, #BOXES, MAX_PARTS))
assert(#BOXES <= MAX_PARTS, "[Hunter] too many parts")
-- ===== END SHARED =====

----------------------------------------------------------------------
-- SCRIPT 2 (run): spawn the plane first, then paste/run this. Works on PC and mobile executors.
-- Paste this BELOW the shared block. Clips ported from the GLB (speed = original in/s, name = clip used in game):
--   idle=idle1  walk=walkN  prowl=a_prowl_n  canter=a_canterN  charge=charge_loop  roar=hunter_angry
--   melee=meleeleft  shoot=shoot_minigun  leap=leap_start  land=leap_land  flinch=flinchleft
----------------------------------------------------------------------
local ANIM_DATA = {
	{ name = "idle", fps = 10, loop = true, nf = 50, speed = 0.00, data = "gA6IgAgM6HgAgZ6GgAgm6Ff/gy6Ef/g76Ef/hC6Ff/hG6Ff/hJ6Ff/hN6Ff/hP6Gf/hS6Gf/hV6Gf/hX6Hf/ha6Hf/hc6Hf/he6Hf/hf6If/hh6If/hi6Jf/hj6Jf/hk6Kf/hk6Kf/hl6Lf/hl6Kf/hk6Kf/hk6Kf/hj6Jf/hh6Jf/hd6If/hQ6If/g+6IgAgs6HgAgc6EgAgP6EgAgB6GgAf26HgAfu6IgAfq6IgAfn6IgAfk6HgBfi6HgBfh6HgBff6HgBff6HgBff6HgBfg6HgBfh6HgAfo6HgAfz6HgAAcogTscnhDucmhzwcliTzckjD2cjjr6cikL9chkb/cgkkAcfksBcek0Bcdk8CcdlMCcclUCcclcCcblcCcblkCcblsCcbl0Ccbl0Ccbl8Ccbl8Ccbl8Ccbl8Ccbl8Ccbl8Cccl8Cccl0Ccdl0CcelkDcik0Ecnj8Gcsi0Hcvh0Gcwg0CcwgL6cwfjzcwfDtcwezrcxejqcxebqcxebqcxeTqcxebqcxebrcwejrcwerscwe7scvfLscqfrsAb5/75b7/b5b9+z5b/+b4cC9z3cG9T2cI871cK8r0cL8j1cN8b1cO8b1cO8T2cP8L2cQ8D2cQ773cQ7z3cQ7z3cR7r3cR7r4cR7j4cR7j4cR7j4cQ7j4cQ7j4cQ7j4cQ7j4cQ7j3cQ7j3cP7r3cP7z1cN8TxcL87rcI9zmcG+jkcC/Llb9/zpL4d37L0eP4Lyef2Lyef1Lxef0Lxef0Lxef0Lyef0LyeX1LyeX1LyeX2LzeX3L0en5L3fH8AbHlZDbJlRDbLlBDbNk5DbPkxEbQkhEbSkZEbSkZFbTkRFbTkRFbUkRFbUkJFbVkJFbVkJFbVkBFbWkBFbWkBFbWkBFbXj5FbXj5FbXj5FbXj5FbXj5FbXj5EbXj5EbXj5EbXj5EbXj5EbXj5EbWkBEbUkJEbRkZDbOkxCbLlBCbJlRCbHlZCbGlpCbElpBbElxBbDl5BbDl5BbDl5BbCl5BbCl5BbCl5BbClxBbClxBbClxBbDlpBbFlhCAb/gAlb/f4kb/f4jb/f4ib/f4hb/f4gb/f4fb/f4fb/f4eb/f4eb/f4db/f4db/f4db/f4db/f4db/f4db/f4db/f4db/f4db/f4eb/f4eb/f4eb/f4fb/f4fb/f4fb/f4gb/f4gb/f4gb/f4gb/f4hb/f4jb/f4lb/f4nb/f4nb/f4ob/f4pb/f4rb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4sb/f4qb/f4nAb/f+tb/f+ub/f+vb/f+wb/f+xb/f+ycAf+zcAf+0cAf+0cAf+1cAf+1cAf+1cAf+1cAf+1cAf+1cAf+1cAf+1cAf+1cAf+1cAf+0cAf+0cAf+0cAf+zcAf+zcAf+zcAf+zcAf+ycAf+ycAf+ycAf+xcAf+vcAf+tcAf+rcAf+rcAf+qcAf+pcAf+ncAf+mcAf+mcAf+mcAf+mcAgGmcAgGmcAgGmcAgGmcAgGmcAgGmcAgGmcAgGocAgGrAdEgDjdBf7jc/fzic9fric6frhc4fjhc3fjhc2fjgc1fjgc1fjgc0fbgc0fbgczfbgczfbgcyfbgcyfbgcxfbgcxfTgcxfTgcwfTgcwfTgcwfTgcwfTgcwfTgcwfTgcwfTgcwfTgcwfTgcxfTgcyfbgc0fbhc3fric7fzjc+fzjdBf7jdEf7kdGgDkdHgLkdIgLldJgLldJgLldJgLldKgLldJgLldJgTldJgTldJgTldJgTldIgLkdGgLkScAf9YST/f7vSb/f7/Sanf8AScWfizSb/gEdAD+/7+EA+sEEA+cFEA+kFEA+kFEB+kDEF+j8EG+j7EG+j7EG+j6EG+j6EH+j5EH+j5EH+j4EH+j4EH+j3EI+j3EI+j2EI+j2EI+r2EJ/b0EK/r1EM/73X+hj+X9hkEX9hkEX8hkGX7hcHX7hcHX3g0AX2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X2gT7X6gD8D+/7+D+/7+AcAgD+cJaT1cJaD1cKZr1cKZb2cJZT/cHZUJcIZUKcIZcLcIZcMcIZcLcIZULcIZMLcIZMLcIZELcIZELcIY8LcIY0LcIY0LcHasKcBfkIb9fsKb4f0Lb+gD7b9gD6b9gD5b9f74b9fz4b9fr3cKjMacNkMjcNkUkcNkkjcMk0icMk0icMk8hcMlEhcMlEhcNlEncOlUtcOlcvcLmUqcLmUqcLmUqcLmUqcLmUqcLmUqcOlkXcQkb7cQkb7ScAgD/AXUtKoXUtSoXUtSpXTtipXStqqXRtyqXRuCrXQuCrXQuKrXQuKrXQuKsXQuKsXQuCsXQuCsXQuCsXQuKsXQuKsXPuKsXPuKsXPuKsXPuKrXPuKrXOuKrXOuSrXNuSrXNuSrXNuSqXNuSqXNuSqXNuKpXNuKpXOuCoXPtynXQtqnXRtimXStalXStalXTtSlXTtSmXUtKnXUtKnXUtKoXUtKoXVtSpXVtapXVtapXVtapXVtapXVtSoXUtSoST/gDRAD+/7+EA/79EC/77EC/76EC/76ED/76ED/75ED/75X9gr1X8g7yX8g7yX8g7yX8g7yX7g7yX7g7xX7g7xX7g7xX7g7xX6hDzX6hDzX6hDzX6hDzX6hDzX6hDzX6hDzX6hD0X6hD0X6g70X6g70X6g70X6g70X6g70X7g7zEF/LqEF+7oEF+7nEF+7nEG+7mEH+7mEG+7mEE/DrD9/b6D8/b9D9/b9D9/b+D+/b+D+/j+D+/r+D+/7+D+/7+AcAgD+cAgL/cAgUBcAgkCcAgsDcAg0Eb/g0Fb/g8FcCjUkcDjsmcEkMncDkUpcCkMpcAkEpcCi0acCi0acDi0bcBlMRcBo0CcBo8CcBo8DcBpEDcBpEEcBpMFcBpMFcBpMEcBpEEcBpEEcApEEcBncPcCnETcCnMUcCf8UcDa8UcEa8VcFa0WcEa0VcEa0VcDa8UcCa8UcGdMacLf0icNgcjcOg0kcOg8kcOhMkcOhUlcIg8XcAgUCcAgMASb/gD/ACo6lpCp6tpCq6toCs6tmCu61kCw61jCx61jCx69iCy69iCx69iCx69jCw7FkCv7FkCw7FkCw7FkCv7FkCv7FkCv7FkCv7FkCv7FkCu7FlCu7FlCu7FlCu69mCu69mCt69nCt69mCs61mCs61mCr61mCr61mCr61oCq6tpCq6tqCp6trCq6trCp6tsCp6trCp6trCp6tqCp6tqCp6tqCp61rCp61sCp61sCp61tCp61tCp61sCo6trCo6tqSUAgDRAEFs0UEEtkTECuUSD/u0SD8vcSD4wERD1wkRDzw0QDyw8PDxxEPDwxMODwxUNDvxcNDvxkMDvxsMDvx0LDvx8LDux8LDuyELDvyMKDvyMKDvyMKDvyMKDvyMLDvyMLDvyMLDvyMLDvyMLDvyEMDvx0ODuxUSDuwcYDuvceDvuchD0tkhD6s0gECsMeEHr0dEJrcdEKrMdEKrEdEKrEdEKrEdEKrEdEJrMdEJrMdEIrcdEIrkcEIr0bEGsUWAcMm9rcLnNscLnltcLn1tcLoNucMolvcNotvcNo1wcMo9wcMo9xcMo9xcLo9xcLo9ycKo9ycJo9ycJo9zcIo1zcHo1zcHo1zcGo10cGot0cFot0cFot0cEol0cEol0cEol0cEol0cEod0cEod0cFod0cGoV0cIoFzcKntxcLndwcMnNvcNm9tcOm1rcPmtqcPmlpcPmlpcQmdpcQmdpcQmdpcQmdpcQmdpcQmlpcQmlpcQmlpcPmtpcOm1qAcAf/pcAf/ocAgHncAgHmcAgHkcAgHicAgHfcAgHecAgHdcAgHdcAgHccAgHbcAgHbcAgHacAgHZcAgHZcAgHZcAgHYcAgHYcAgHYcAgHXcAgHXcAgHXcAgHXcAgHXcAgHXcAgHWcAgHWcAgHXcAgHXcAgHXcAgHZcAgHbcAgHdcAgHhcAgHkcAgHncAgHpcAgHqcAgHqcAgHqcAgHqcAgHqcAgHqcAgHqcAgHpcAgHpcAgHpcAgHpcAgHpAb/gA2b/gA3b/gA4b/gA5b/gA7b/gA+b/gBBb/gBCb/gBDb/gBEb/gBFb/gBGb/gBGb/gBHb/gBIb/gBIb/gBJb/gBJb/gBJb/gBKb/gBKb/gBKb/gBLb/gBLb/gBLb/gBLb/gBLb/gBLb/gBLb/gBLb/gBKb/gBJb/gBGb/gBDb/gA/b/gA7b/f44b/f42b/f41b/f40b/f40b/f40b/f40b/f41b/f41b/f42b/f42b/f42b/f42b/f42AcNe9rcMetrcLeVqcJeNpcHd9ocEdtncDdlmcCdlmcCddlcCddlcCdVlcCdVkcDdNkcDdNkcEdNkcEdFjcFdFjcGc9jcGc9jcHc9jcIc9jcIc9icJc1icJc1icKc1icKc1icKc1icKc9icKc9icKdFicKdVjcKdljcLeFkcMeVmcMetncNe9pcNfNrcNfVscNfdscOfltcOfltcOfttcNfttcNfttcNfttcNfttcNfltcNfltcNfdscNfNsScSgqpST2iD7AK4OnVK3OnTK3OfPK2OXLK1OXJK1OPKK0OXOKzOXTKyOnZKxOveKxOvgKxOnfKwOncKvOnaKvOnaKwOvbKwOvcKxOvcKxOnbKyOfZK0OXYK1OXWK1OPVK2OPVK2OPVK2OXWK2OXWK2OfXK1OfXK1OfXK0OnYKxOvcKtO/haq8h5KpPPkKqO/gKsOvZKvOfSKyOPLK1OHFK3N/CK3N/CK0N/FKyN/KKxN/NKyOHPKzOPRK1OXTK2OfUK3OnVAabW1pabW1oabW1oabW1nabW9nabW9maaW9maaXFmaaXFmaaXFnaaXNpabXNqabXNrabXFsacXFtacW9uadW1vadWtwaeWtxaeWtyaeWt0aeWt1aeW12aeW12adW10adW9yadW9vadW9radXFpadXFnadW9maeW9naeW1paeWtqaeWtraeWtsadWtradW1qacW9oacXNnabXNmabXNnacXFpadW9sadW1vaeWtwaeWtwadWtvacWtsabW1qAUSaLPUSaLOUSaLOUSaLOUSaLNUSaLNURaLNURaLNURaLNURaLNURaLOURaLOUSaLPUSaLRUSaLTUTaLUUUaTWUVaTXUWabYUWabZUXabZUXabYUXabYUXabYUWabXUVabWUUaTVUSaTTURaTSUQabRUPabPUOabKUNabCUMai7UMai4UNai7UPajEURajPUTabWUUabWUUaTUUTabQUSabPUSabPUSabPUSabPUSaTPUSaTPUSaLPUSaLPAUEf0ZUEf0ZUEf0ZUEf0aUEf0aUEf0bUEf0cUEf0cUEf0cUEf0cUEf0cUEf0cUEf0dUEf0dUEf0dUEf0dUEf0dUEf0dUEf0dUEf0eUEf0eUEf0fUEf0fUEf0gUEf0hUEf0hUEf0hUEf0gUEf0gUEf0gUEf0gUEf0fUEf0eUEf0dUEf0dUEf0eUEf0eUEf0fUEf0hUEf0iUEf0iUEf0iUEf0hUEf0gUEf0fUEf0eUEf0cUEf0bUEf0aUEf0ZAV0kDrVuj7sVojzuVkjrwVfjbyVajL1VWi74VUiz5VSij5VRib5VQiT5VPiL5VOiL6VNiD6VMiD6VLh76VKh76VJh76VJh76VIh76VIh76VHh76VHh76VHh76VHh76VHh76VIiD6VIiD6VJiD6VLiT7VQir+VXjMCVgjsEVoj8EVvkMBV1kj7V5kz0V9lDvV/lLtWBlLtWClLtWClLsWClLsWClLsWClLsWBlLsWAlLtV+lLtV8k7tV4kTrAbxaGQbwaOPbuaWObsaeMbqaeLboaeKbmaeJbkaeIbjaWIbiaWIbhaWHbhaWHbgaWHbgaWHbfaWHbeaWHbeaWHbeaWHbdaWHbdaWHbdaWHbdaWHbdaWHbdaWHbdaeHbdaeHbeamHbfamHbgauHbia2Ibma+Ibra+JbwbGJb0bOKb4bOMb7bWOb+beQb/beScAbeTcAbeTcBbWUcAbWUcAbOUcAbGUb+a+Tb9auTb7aeTb5aOSb2Z+RbzZ+RAb/gHtb/gHvb/gHxb/gHyb/gH1b/gH3b/gH4b/gH4b/gH4b/gH4b/gH4b/gH4b/gH4b/gH4b/gH3b/gH3b/gH3b/gH2b/gH2b/gH1b/gH1b/gH1b/gH0b/gH0b/gH0b/gH1b/gH1b/gH1b/gH1b/gH1b/gH4b/gH7b/gH+b/gH+b/gH8b/gH3b/gHyb/gHtb/gHrb/gHrb/gHrb/gHrb/gHrb/gHrb/gHrb/gHsb/f/sb/f/sb/f/sb/f/tAb/f48b/f46b/f44b/f42b/f40b/f4xb/f4wb/f4wb/f4wb/f4wb/f4wb/f4wb/f4wb/f4wb/f4xb/f4xb/f4xb/f4yb/f4yb/f4zb/f4zb/f4zb/f40b/f40b/f40b/f40b/f40b/f40b/f40b/f4zb/f4wb/f4sb/f4qb/f4pb/f4sb/f4xb/f42b/f47b/f49b/f4+b/f4/b/f4+b/f4+b/f4+b/f4+b/f49b/f49b/f48b/f48b/f48AcEksxcEkcycEkMzcFj80cGjs1cHjc2cIjM3cKjM3cLjE4cMi84cMi84cNi04cNi04cOi04cOis4cOis4cPik4cPik4cPik4cQik4cQic4cQic4cPic4cPic4cPic4cOic4cOic4cNic4cLik4cJik4cGi84cCjU3b+js3b7kM2b4kc0b1ksybzk8wbylEvbylMubxlMubylUtbylUtbzlUtb0lUtb1lUub4lUub7lUub+lUvcBlMvcDk8wSb8fyuSUCfsCAZN2yJZO3aHZR4yBJUPnHJWPPBJVPfFZS5CBZP3aHZP2aKZT2SHZZ2iBZd259Zb3J/ZU3aFZN3iLZL3aNZM3KMZM26KZM2yJZM2yIZL2yIZL2yHZK26GZK26FZJ3CFZJ3CFZJ3KFZJ3CFZJ3CFZI26GZG2aJY90SSY4zaWY3ziVY50KSZC2SIZK36BZO45+JSPHDJRPPBJNPvDJKQXHZG5KGZE4yJZE4iKZF4SKZH36KZJ3iKZL3KKZN26JAd2k/Gd2k/Gd2k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd1k/Gd2k/Gd2k/Gd2k/Gd2k/Hd2k/Hd2k3Hd2k3Hd2k3Hd2k3Hd2k3Hd2k/Gd2k/Gd1k/Fd1lHEd1lHDd1lPCd1lPBd1lXAd1lW/d0lW/d0lW/d1lPAd1lPBd1lPBd1lXAd0lW+d0le8d0lm6dzlu5dzlu5d0lm6d0le8d0lW+d1lPAd1lPCd1lHEd2k/FATqlrpTqlrpTqlroTqljoTrljnTrljmTrljmTrljlTrljmTrljmTrljmTrlrnTrlzoTrlzpTrl7qTrl7qTql7qTql7rTql7rTql7sTql7tTqlzsTqlzsTqlzsTrlzrTrlrqTsljoTtlbmTtlTlTulLkTulLkTulLkTtlTlTtlTlTslTmTslbnTrlbmTrlbmTrlbmTslTlTslLkTslLjTslDiTslDjTslLjTrlTkTrlTlTrlbmTqljoTqlrpAT7gMjT7gMjT7gMjT7gMjT7gMjT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMkT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjT7gMjAXycToXycToXycbpXycjqXzcrqX0czsX1dDtX2dDvX3dLzX4dL3X4dD8X5dEBX5c8FX5csIX5ckJX6ccJX6cUGX6cECX6bz9X5bj3X4bTwX3bDqX2azlX0argX0abdXzabbXzajaX0bbaX1czYX1ezTX1hTKX0jjAXzki7X0jjAX2g7OX4dzdX4bLmX3aDlX1Z7eX0aLZX0aLZX0aTaX0ajbXzazdXzbDfXzbThXybjjXybzlXycDnXycLoAb8c2Vb6dWUb3eeQb0fmLbzgODb1f95b6e9rb+d1ccBc9QcCctKcCclEcDcc/cDcc7cDck4cDck1cDcszcDc0wcDc0ucEc0scEc0rcEc0pcEc0pcEc0ocEc0pcEc0qcEc0scDc8xcCdE+cBdNLcBc9ScDcFNcFas/cHZUucIYUicIYMccHYkYcHZUWcHaEXcHa0ccHbUlcIb0zcIcNFcJctYcIdFtcIdeAcHd2RcFeGdcDd+jcAdmgb9dGZAX8ez3X8fD3X7fT4X6fz5X5gD5X5gL5X5f73X5fj1X5fLzX5erwX5eTuX5d7sX4dzrX4d7qX4eLqX3errX3fLsX3fjuX3f7vX3gDwX3f7wX4fjxX5fLxX6e7yX7eryX7ezyX7fLxX7frwX7gbuX6hbpX4jbeX2lLSX2lbQX2kjVX3jLdX4hjlX4gDuX5er0X4dr2X4dDzX3cbvX3cDqX2b7mX2b7lX3cLmX4cjpX5dLsX6dzwX7eTzX8er2Ab/f+Wb9guab3iGhbzjGjbzjGdb2imRb6huCb9g1zb/gNob/gFkb/gFpb/gFyb/gF+b/f+Kb/f+Sb/f+Vb/f+Ub/f+Rb/f+Nb/f+Jb/f+Gb/f+Db/f+Bb/f+Bb/f+Cb/f+Eb/f+Fb/f+HcAf2HcCfOHcEemGcGd+FcHduEcFeGDcCfGCcAf+Bb/gGAb/gF+b/gF8b/gF6b/gF5b/gF4b/gF5b/gF8b/gGCb/gGHb/gGMb/gGQb/gGTb/gGV" },
	{ name = "walk", fps = 20, loop = true, nf = 25, speed = 162.96, data = "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" },
	{ name = "prowl", fps = 20, loop = true, nf = 17, speed = 204.32, data = "gA3agAgG3vgAga3sgAgw3hgAg93OgAhH24gAhc2tgAh02zgAiD3IgAiC3hgAh333gAhn4AgAhT32gAg+3dgAgq3BgAgY2vgAgJ23gAAdxdDndvcLudpbb2dia78dfa0DdhbEIdob8NdvdERdzeUTdwfkSdpgULdgg8BdZhL3dYhDvdcgTmdkfTgdseDgAal8Skae76caj8Kia69K7bc+Dgbk+Tpbf+LjbF9jHaR7CNZh3BXWyLREZS1RGZp35haO66Ka99K+bj+DobS9zVAaynaNaoo6makqyua0tSgbYuRtbhuRgbpspAbqqoqbko4ybbnJNbeliCbmkSjbrjKWbnihubejQ+bUlQfbFm5AAT/f4FcAgAicAgBFcAgAuT/f4BT/f4gT/f5WT/f5EcAgAKcAgBvcAgBYcAgAOT/f4jT/f46T/f41T/f4hT/f4VAb/f/Zb/f+wb/f+Ob/f+lb/f/Vb/f/zT/f/fT/f/ub/f/Kb/f9pb/f99b/f/Fb/f/2T/f/1T/f/6b/f/0b/f/pAdDdz2dOebxdXeT0dWdkBdEcUadJfD+dDhbCc4iKccwhapcrgjLcmfjWciebfcgdruchdb7cndT+cvdL9c5dT7ScAgFYSUAgDvSc+WUkSanf7/ScWfizSb/f8dAX6gjwX9gLyX/fjyD3/rxD0/rwD2/rwX+fbwX8gLwX4gruX0gzrXxgbmXuf7hXsfreXsfjeXuf7hXygTnX2gjsAb3byfbzbigbvbSibsbKlbrbCnbsbKmbubajbybqgb2cCfb6cagb+cyjcCdCncEdKpcEdCqcCc6nb/cikb7cKhSb/f7/SXUtKoST/gDRAX8gzzX+gb1D//z1D7/r0D5/jzD7/rzD//z0X9gjzX7g7yX4hDvX1gzqXygbmXxgLkXxgDkXzgTnX2grrX5g7wAb0dqobvdSpbrdCsbocyvbmcyxbncyvbqdKsbvdipb0d6nb5eapb+eytcCfCycEfK1cFfK1cCe6yb+eiub5eCqScAf7/SCo6lpSUAf7RAGCebtFvhEOFojr/F4nK0F1nZ9FvmJxFrjxtFkhRsFbgR2FNhCKE6iijEnj67EdjbSEsezrFNZD7FsYLvGEbrZAau32Ua41WEady1zZTvdbYru08Ysxc9Yz1tDZD6NIJeqvQKFs/ia27l9bl32QcT0WidG0+ydS6exMh1vUbM62lAUAgF/UAgGgUAgHTUAgH9cAgH3UAgHpUAgHPUAgHGUAgHMUAgHWUAgHeUAgHlUAgHxUAgH7UAgHPUAgGrUAgGdAUAgBrUAgBKUAgAUb/f4ZcAf4lb/f4DUAgAZUAgAhUAgAbUAgAQUAgAJUAgACb/f4Lb/f4XUAgAZUAgA+UAgBOAbzmeUbpnE7bwk8YbrlMLbQncpbLoMvbXnkqbqmUpb+lUqcSk0rcnksxc9ks3dFlM6cVl9Hbnj+HbfjO3bykXNScSgqpST2iD7SK4OnVSabW1pSUSaLPSUEf0ZAWuu05Wuz1GWg5U/ON8svOB7skNo8svM49FcM08V/NP7OCNy5F4OV2dqOj2E7OZ3DmOZ3TYWE9D0V21LtWVuMPAcEenUbmk/8SypfXR+sm0RdvGZRGqGNRGeV2RiamARwb+hR5fHNaIj3vZ9mHPZWlWcZjouLafiWjbAX+Tb0XmgAUAgHPUAgHoUAgH4cAgH6cAgHuUAgH+UAgHlUAgHTUAgG8T/gGpUAgHbcAgHjcAgG4cAgG8cAgHdUAgHiUAgHDAUAgAFb/f4Rb/f4gb/f4tb/f46b/f4nb/f4OUAgACUAgAVUAgAkb/f4Gb/f5Gb/f5xb/f5tb/f5Mb/f4LUAgAPAbTbD6a3bL7adccEaIdcLZ6dcEaNelIbAd+0a2aW0anYGZbAY1wbvdElcXgMEcZfcDapakcaKasza6bkrbbb0PSb8fyuSUCfsCSZN2yJSd2k/GSTqlrpST7gMjSXycToSb8c2VSX8ez3ScAf+W" },
	{ name = "canter", fps = 20, loop = true, nf = 20, speed = 279.53, data = "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" },
	{ name = "charge", fps = 24, loop = true, nf = 18, speed = 358.90, data = "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" },
	{ name = "roar", fps = 16, loop = false, nf = 41, speed = 0.00, data = "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" },
	{ name = "melee", fps = 20, loop = false, nf = 35, speed = 0.00, data = "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" },
	{ name = "shoot", fps = 24, loop = false, nf = 8, speed = 0.00, data = "gA3jgAgA3jfegA3je8gA3jfEgA3jfUgA3jfogA3jf5gA3jgAAdCg74dPhL1dYhTzdWgb4dOfr9dHgD9dCgj7dCg74Abl/rkba/TdbS/DXLXav6Lha32Lmbn5LocX8bl/rkAb2b53b2b5zb1b5xb1cJxb1cRzb1cJ1b2cB3b2b53Ab/f5Ab/f4+b/f46b/f46b/f45b/f46b/f49b/f5AAb/f+Tb/f+Ub/f+Yb/f+Yb/f+Zb/f+Yb/f+Wb/f+TAbwiCpbxiKtbxiKwbziKwb0iCtbziCrbxiCpbwiCpScAf9YSUAf7vAcXV0dcQWkqcNXMzcMWMncOVMZcWV0ecbW8ocXV0dSanf7/ScWfizScAf8dAX4jcZX2kEeX0kkhX3kchX6j8fX5jscX4jcZX4jcZAcAgT7cAgj0cAgrvb/gDwb/fb0b/fj4b/f77cAgT7SEAgCNAEu8RoFB8J1FU8KEFO8R/FE8Z3FC8p4FE857Eu8RoAcAf7QcHfK1cOeCYcMdy3cIdrdcHd7QcHeKzcAf7QAX5jsaX1ksgX0k8jX2k0jX4ksiX4kcgX2kcfX5jsaAcAgj6cAgb2cAgjyb/f70b+fT5b/fb+b/f0CcAgj6SEAgB0AB0806B+8lHCJ8dVCE8tLB79E+B39E5B0885B0806AcAf7ib5hCxb1iKCb3h65b7hj/bvhrKbjiZ9cAf7iAEGs0YEMtEkEQtUsEKscsEDr0mEBsEeECssYEGs0YAcsoE+cooM6cjoc3cloM4cnoE7cqn89croE+csoE+AT/gH1T/gH3T/gH6T/gH6T/gH5T/gH3T/gH2T/gH1Ab/f4Qb/f4Sb/f4Wb/f4Wb/f4Ub/f4Tb/f4Rb/f4QAbnkmHbokGMbqjuQbqj2ObqkOLbpkWIbnkeHbnkmHScSgqpST2iD7SK4OnVSabW1pSUSaLPSUEf0ZAV0kjtVymLuVxnbwV3mz0V9lr3V6kz0V2kTwV0kjtAanc9iapcteasclaascdZaqcdaapcldaoc1ganc9iAUAgHlUAgHkUAgHjUAgHhUAgHgUAgHhUAgHjUAgHlAcAf4OcAf4NcAf4McAf4LcAf4KcAf4LcAf4NcAf4OAcua8+ctbVCcsblHctbtHcublGcubVDcubFAcua8+Sb8fyuSUCfsCSZN2yJSd2k/GSTqlrpST7gMjSXycToSb8c2VSX8ez3Sb/f+W" },
	{ name = "leap", fps = 20, loop = false, nf = 14, speed = 0.00, data = "gAwwgAgNuchMgxtOiphdsxkNiJs1lviptPnFi7t0oBjIuaojjPvAo1jSvlo8jRwLo/jMwyo4jExcopi5yJoUAbVgbicPfzfc5fTidLfTrdRfj4dPgEHdJgkSdAg8Xc1hcZcph0ZceiUXcUikVcNi0TcJi0RAdX99XNisXrNdrvtNUqnxNIpH0M7nf4Mrlf7Mcjn9MMhn/b+/7+bx/7xbn/znbh/rhbf/rfAciV5OceTAzclQQrdFNAudtLg0Rgyg6e3PQ8fBQxWfARKDe+S6me7Vq8e1YTEenZzIeZajOAT/gAtT/gAJcAf4UcAf47cAf52cAgDrcAgD/cAgDfcAf51cAf4rcAf4CT/gAXUAgASUAgASAcAf/+cAf/dcAf+/b/f+Yb/f9jb/f8Nb/f8Ab/f8Vb/f9lb/f+nb/f/Sb/f/rb/f/mb/f/mAalaZjaQYpIZ8W4/ZnT5IZaRZUZWPpeZWPZfZaPhcZfQBWZqQpQZ5RRPaIRpXaWS5aagUBYSb/f9YST/f7vScAf8ASangEAScWfizSb/gEdAXygD4XxjEgXvjUuXskU/XomNTXonFYXrmFKXwkUzXxi8iXxiMaXwiEXXvh8YXvh8XXwh0UScAgD+Sb/f7/SXUtKoSUAgDRAX0fLxX0hMRXyg8cXviUxXskdGXtk9IXwkE7XyjMqXxiMcXuhkVXqhkTXmhsUXjhsUXkhkRScAgD+ScAgEASCo6lpSUAgDRAHCsbRP3krVP1iLDHxgi2HafayHBe68GrfTNGYfzbGGgrnF1hrxFnir5Fajr+FPkkDFGlcGAadfHzRocPlZrle8aRuuPaYx2Han0mMa/2OTbX2+Wbs3OXcA3GWcT2uTcj2GPcu1eLc10uLAUAf+lUAf/pUAf/NUAf+dUAf90UAf9eUAf9fUAf9mUAf9vUAf96UAf+FUAf+RUAf+fUAf+pAT/gBFcAf4DT/gAaT/gBNT/gB2T/gCLUAgCKUAgCEUAgB7UAgBxUAgBmUAgBaUAgBLUAgBAAdEfF2dVfGpbnjGxaNnWhaIoGNaQn94aWndqabmtjael1hahlFfaikdfajj1gakjdgali1eScSgqpST2iD7SK4OnVSabW1pSUSaLPSUEf0ZAVnd1/UVc3IT9Z3cT1WfjT1UnjT2UHiT3TneT6S/XT+SXPUCR3EUGRm5UKRutUOSOiUTTWXAcLWfqdSUnmdbIuRdnJV9dbKF7dFKmBc0K2FcpK+HcgK+IcXK+HcOLGHcGLGHb9LWIb2LuKAT/f+FT/f+IT/f+FT/f9zUAf9sUAf9yUAf99UAf+KUAf+XUAf+iUAf+tUAf+2UAf/AUAf/DAT/f5AT/f4+T/f5AT/f5MT/f5RT/f5NT/f5FT/f48T/f4yT/f4qT/f4hT/f4ZUAf4SUAf4PAcoe1ScCdmAd/YWDeHVV4eIS1oeFRdbeBRFSd/RNNd8RlKd6SFId4StHd2TlHd0UlIdvV1ISb8fyuSUCfsCSZN2yJSd2k/GSTqlrpST7gMjSXzeD2Sb8c2VSX8ez3Sb/gGW" },
	{ name = "land", fps = 16, loop = false, nf = 18, speed = 0.00, data = "gAtegAg2syh9hts3j2iOtelYihuOmUisu8msiwvrm1iswbm0ikxNmniXyFmOiGzDluhv0IlKhV1Qkkg72Vj+gh3XjagM4Oi7f747ihfz5QiUAcxfbgdKfTqdRfr7dNgUMdDg0Wc2hUZcnh8ZcZicWcPi0UcJi0RcFisOcAicKb7iEFb3hsAbzhT7bwg73bvgr0bvgjyAdf9lfdV+FVdG+tGc0/M0MhkP9MOh3/L7ff/Ltdv+LicX9Lfb/9LicX9Ltdv+L7ff/cL/8Lcb/0bco/kocx/Uxc0/U0AccRYsdCNQud0LY1RVxw4fBQxJfBRJ/e9Tare5WzAerZjGebajNeBbLLdgcK9c7dqmcYfyKb7iBublkBXbVlhGbNmJAAb/gAJb/gA3b/gCBb/gD1b/gD/b/gB+b/gAiUAf4LUAf4TUAf4SUAf4XUAf4aT/f4aT/f4WT/f4PT/f4HT/f4BcAgABAb/f/Kb/f+bb/f9Zb/f8Gb/f8Ab/f9db/f+wb/f/fb/f/nb/f/mb/f/rb/f/tb/f/tb/f/qb/f/jb/gHbb/gHVb/gHTAaEYA9ZoUJHZYRBVZWPheZZPheZfP5XZsQxQZ/RRTaTShaafT5YawWBYbGYpgbhbJwb+dCGcYeiectfS2c9f7IdFgTQSb/f9YST/f7vSb/gEASanf8AScWfizScAgEdAXwjUrXskM9XomlVXpmtTXuk06XxjEjXxiMZXwiEXXvh8YXwh0UXxhcQX0hMMX2g8IX5gsFX7gcCX9gMAX+f7/D+/7+ScAgD+ScAgEASXUtKoST/gDRAXzg0XXviMuXsk1JXuktDXyjkwXyiMdXuhkUXohkTXkhsUXkhkSXmhUNXphEKXug0HXzgkEX3gUCX7gEAX+f7/D+/7+Sb/gD+Sb/f8ASCo6lpSUAf7RAPyizJHzgq3HVfKyG4fDDGefjXGHgjmFzhzyFhjD7FSkUCFHlUGE/mcJE7nsJE5o0IE5qEHE6rMGE6sEFE6s0EE4tEEAZbgPMaQueRaYyWHax1OPbP22Wbq3OXcE3GVca2eScr1uNc002Lc5z2Qc7yuVc7xebc6wWhc5vOoc3uGvc1tO1czsu3AUAf/dUAf+hUAf9uUAf9eT/f9jT/f9vT/gF8T/gGKT/gGaT/gGpT/gGzT/gHDT/gHVT/gHpT/gH7b/gH0b/gHob/gHkAUAgAKUAgBJUAgB8UAgCLUAgCHUAgB8UAf5vUAf5hUAf5RUAf5BUAf42UAf4lUAf4Sb/gACb/gAXb/gApb/gA3b/gA7AcdhG5aPnOjaJoGJaSn1yaZm9lael1hahk9fajkNfajjlgali1faoh1aarg1Xauf1Wawe1Vayd9Ta0dFRa2cVNa4b9KScSgqpST2iD7SK4OnVSabW1pSUSaLPSUEf0ZAUBbHZT1WviT1UXjT2T/gT5TPaT+SXPUDRvCUIRm0UNR+mUTTWYUbVeIUnYN0U1bVcVGeNAVWgsjVkicJVvjr0V0kDrAdTIWadnJV+dYKN7c+KuDcsK+HchK+IcWK+HcLLGHcALWIb3LuKbtMWRbgNmabRPWibDRmqa4UOvayWuxawYuxaxZmyAT/f+LT/f91T/f9sT/f93T/f+GT/f+WT/f+kT/f+xT/f+9T/f/DT/f/CT/gHGT/gHOT/gHaT/gHoT/gH2b/gH9b/gH4AUAf47UAf5LUAf5RUAf5KUAf4/UAf4zUAf4oUAf4eUAf4UUAf4PUAf4QUAf4NUAf4Gb/gAEb/gARb/gAeb/gAqb/gAwAd7ZOEeHVt6eISdleERVXd/RFPd9RdLd6SNId3TFHd0UNHdwVtIdoX1HdgaNGdZclFdTe1DdOg1AdLic8dIjs3dGkUzSb8fyuSUCfsCSZN2yJSd2k/GSTqlrpST7gMjSXzeD2Sb8c2VSX8ez3Sb/f+W" },
	{ name = "flinch", fps = 20, loop = false, nf = 14, speed = 0.00, data = "gA6IgAgq6KfvhZ6QfVhp6WfNhn6YfPhc6YfahL6Xfrg56Qf3go6Jf+gZ6IgCgN6IgDgF6IgBgB6IgAgA6IgAAcogTscpfzrctgLlcxhjdczijZcyjDbcxi7gcwijlcuh7qcshLtcrgbvcqgLvcpgDtcogDsSb5/75AbHlZDbMmBAbRlA4bSiwwbShAtbUgotbUhIxbTiA1bSjI6bPkQ9bNlZAbKlxBbHlxCbHlpCAcAgAlb/gAmb/gAsb/gA1b/gA7b/gA9b/gA6b/gA0b/gAub/gArb/gApb/f4nb/f4mb/f4mAcAf+tcAf+scAf+mcAf+dcAf+XcAf+WcAf+Yb/f+eb/f+kb/f+nb/f+pb/f+qb/f+rb/f+sAdEgDjdBfLkc6eboc1ejrcye7scyfTrc0fjoc4fzmc7fzkc/f7jdCf7jdEf7jdEf7jdEf7jSb/gFYST/f7vSb/f7/SangD/ScWfizScAf8dSD+/7+Sb/gD+Sb/f7/SXUtKoST/gDRSD+/7+ScAgD+ScAf8ASCo6lpST/f7RSEFs0UAcAndvb4nFwbzoFrb3p1ib8rNdb+rteb/rdjb+q1nb9p9rb8o1ub7n9wb8ndwb+nNvb/nNuAcAgHbcAgHdcAgHdcAgHccAgHacAgHYcAgHYcAgHacAgHbcAgHccAgHbcAgHbcAgHbcAgHbAb/gBGb/gBEb/gBEb/gBFb/gBHb/gBJb/gBJb/gBHb/gBGb/gBFb/gBGb/gBGb/gBGb/gBFAYwMUPYyMMJY1LkCY2K8AY1KsBYzK0CYyLEEYxLcHYwLsJYwMELYwMUNYwMcOYwMcPYwMcPScSgqpST2iD7SK4OnVSabW1pSUSaLPSUEf0ZSV0kDrAb0Z+PbwZWLb1ZuKcAa+OcIcGRcIc2RcEc2Pb/ceMb7b2Kb2a+JbzaOJbyZuLbzZmObzZuPAcAf/qcAf/lcAf/YcAf/Pb/f/Nb/gHRb/gHbb/gHkb/gHrb/gHub/gHvb/gHtb/gHrb/gHqAb/f4+b/f5Fb/f5Rb/f5ab/f5db/f5Yb/f5Pb/f5Fb/f4+b/f46b/f45cAf47cAf49cAf4/Ae8rESe9rMYe9q8de7qcee6qEde5p8ce5p8be6qEZe6qcYe7qsWe8rEVe8rMUe8rMTe8rMSSb8fyuSUCfsCSZN2yJSd2k/GSTqlrpST7gMjSXycbnSb8c2VSX8ez3ScAf+W" },
}

----------------------------------------------------------------------
-- ANIMATIONS (ported from the GLB: 20-24 fps resamples, root motion removed on locomotion clips)
----------------------------------------------------------------------

----------------------------------------------------------------------
-- ANIMATIONS (ported from the GLB: 20-24 fps resamples, root motion removed on locomotion clips)
----------------------------------------------------------------------
local NB = #BONE_NAME
local BT = {}
for i = 1, NB do
	local t = BONE_T[i]
	BT[i] = V3(t[1] * SCALE, t[2] * SCALE, t[3] * SCALE)
end

local CLIPS = {}
for _, a in ipairs(ANIM_DATA) do
	local rd, ch = newReader(a.data)
	local clip = { name = a.name, fps = a.fps, loop = a.loop, nf = a.nf, speed = a.speed * SCALE, root = {}, rot = {} }
	for f = 1, a.nf do
		local x, y, z = (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05
		clip.root[f] = V3(x * SCALE, y * SCALE, z * SCALE)
	end
	for b = 1, NB do
		local kind = ch()
		local list = {}
		if kind == "S" then
			local q = unpackQ(rd(5), 9)
			local c = CFn(0, 0, 0, q[1], q[2], q[3], q[4])
			for f = 1, a.nf do list[f] = c end
		else
			for f = 1, a.nf do
				local q = unpackQ(rd(5), 9)
				list[f] = CFn(0, 0, 0, q[1], q[2], q[3], q[4])
			end
		end
		clip.rot[b] = list
	end
	clip.length = a.loop and (a.nf / a.fps) or ((a.nf - 1) / a.fps)
	CLIPS[a.name] = clip
end

-- sample a clip at time t -> { rot = {CFrame per bone}, root = Vector3 }
local function sampleClip(clip, t)
	local nf = clip.nf
	local idx = t * clip.fps
	local f0, f1, a
	if clip.loop then
		idx = idx % nf
		f0 = math.floor(idx)
		a = idx - f0
		f0 = f0 + 1
		f1 = f0 % nf + 1
	else
		idx = math.max(0, math.min(idx, nf - 1))
		f0 = math.floor(idx)
		a = idx - f0
		f0 = f0 + 1
		f1 = math.min(f0 + 1, nf)
	end
	local rot = {}
	for b = 1, NB do
		local l = clip.rot[b]
		if l[f0] == l[f1] then rot[b] = l[f0] else rot[b] = l[f0]:Lerp(l[f1], a) end
	end
	return { rot = rot, root = clip.root[f0]:Lerp(clip.root[f1], a) }
end
local function blendPose(p0, p1, a)
	if a <= 0 then return p0 elseif a >= 1 then return p1 end
	local rot = {}
	for b = 1, NB do rot[b] = p0.rot[b]:Lerp(p1.rot[b], a) end
	return { rot = rot, root = p0.root:Lerp(p1.root, a) }
end
local function worldPose(pose)
	local W = {}
	for i = 1, NB do
		local p = BONE_PARENT[i]
		if p == 0 then
			W[i] = CFn(pose.root) * pose.rot[i]
		else
			W[i] = W[p] * CFn(BT[i]) * pose.rot[i]
		end
	end
	return W
end
-- ===== END ANIMATION CORE =====

----------------------------------------------------------------------
-- GAME LOGIC
----------------------------------------------------------------------
if getgenv().HunterRunning then warn("[Hunter] already running - run getgenv().HunterStop() or rejoin") return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local CFG = {
	PLANE_MODEL = nil,        -- set to the spawned plane Instance if auto-detection picks the wrong one
	BREAK_JOINTS = true,      -- cut the welds/joints of the plane parts (client side) so every part can move on its own
	SPEED_SCALE = 0.5,        -- 1 = move exactly as fast as the original animation (feet never slide); 0.5 = half speed, anim slowed to match
	JUMP_VELOCITY = 95,       -- studs/s
	CAM_DIST = 95, CAM_MIN = 35, CAM_MAX = 260, CAM_HEIGHT = 26,
	FADE = 0.18,              -- seconds of crossfade between animations
	MOBILE_UPDATE_EVERY = 2,  -- on touch devices move the parts every N frames (performance)
	CHARGE_AFTER = 1.4,       -- seconds of continuous running before the charge animation kicks in
}
local isTouch = UIS.TouchEnabled
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local guiParent = (gethui and gethui()) or lp:WaitForChild("PlayerGui")
pcall(function()
	for _, n in ipairs({ "HunterGen", "HunterUI" }) do
		local old = guiParent:FindFirstChild(n)
		if old then old:Destroy() end
	end
end)
local sg = Instance.new("ScreenGui")
sg.Name = "HunterUI"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
pcall(function() sg.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets end)
pcall(function() sg.Parent = guiParent end)
local info = Instance.new("TextLabel")
info.BackgroundTransparency = 0.35
info.BackgroundColor3 = Color3.new(0, 0, 0)
info.TextColor3 = Color3.new(1, 1, 1)
info.Font = Enum.Font.Code
info.TextSize = isMobile and 15 or 13
info.TextWrapped = true
info.AnchorPoint = Vector2.new(0.5, 0)
info.Position = UDim2.new(0.5, 0, 0, 8)
info.Size = UDim2.new(0.8, 0, 0, 44)
info.Parent = sg
local ilim = Instance.new("UISizeConstraint")
ilim.MaxSize = Vector2.new(520, 120)
ilim.Parent = info
local function say(t, hold)
	info.Text = t
	print("[Hunter] " .. t)
	if hold then
		local mine = t
		task.delay(hold, function() if info.Text == mine then info.Text = "" info.Visible = false end end)
	end
	info.Visible = true
end

----------------------------------------------------------------------
-- find the spawned plane's SmallParts and pair them with the 1400 boxes
----------------------------------------------------------------------
local function findPlane()
	if CFG.PLANE_MODEL then return CFG.PLANE_MODEL end
	local plotRoot = workspace:FindFirstChild("PIayerAircraft")
	local plot = plotRoot and plotRoot:FindFirstChild(lp.Name)
	local best, bestN
	local function consider(inst)
		if plot and (inst == plot or inst:IsDescendantOf(plot)) then return end
		local n = 0
		for _, d in ipairs(inst:GetDescendants()) do
			if d.Name == "SPart" and d:IsA("BasePart") then n = n + 1 end
		end
		if n >= 50 and (not bestN or n > bestN) then best, bestN = inst, n end
	end
	for _, c in ipairs(workspace:GetChildren()) do
		if c.Name == lp.Name then consider(c) end
		if c ~= plotRoot and c ~= lp.Character then
			local mine = c:FindFirstChild(lp.Name)
			if mine then consider(mine) end
		end
	end
	return best
end

local plane = findPlane()
assert(plane, "[Hunter] spawned plane not found - spawn it first (or set CFG.PLANE_MODEL)")
local planeParts = {}
for _, d in ipairs(plane:GetDescendants()) do
	if d.Name == "SPart" and d:IsA("BasePart") then planeParts[#planeParts + 1] = d end
end
say(("Plane found: %d SmallParts, need %d"):format(#planeParts, #BOXES))

-- match by (colour, size) so the order of the parts does not matter
local function c255(c) return math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5) end
local bucket = {}
for i, b in ipairs(BOXES) do
	local k = b.r .. "," .. b.g .. "," .. b.b
	bucket[k] = bucket[k] or {}
	table.insert(bucket[k], i)
end
local boxOf, usedBox = {}, {}
local leftoverParts = {}
local TOL = 0.035
for pi, part in ipairs(planeParts) do
	local r, g, b = c255(part.Color)
	local sx, sy, sz = part.Size.X / 2.5, part.Size.Y / 2.5, part.Size.Z / 2.5
	local found
	local list = bucket[r .. "," .. g .. "," .. b]
	if list then
		for _, bi in ipairs(list) do
			if not usedBox[bi] then
				local bx = BOXES[bi]
				if math.abs(bx.gx - sx) < TOL and math.abs(bx.gy - sy) < TOL and math.abs(bx.gz - sz) < TOL then
					found = bi
					break
				end
			end
		end
	end
	if found then usedBox[found] = true boxOf[pi] = found else leftoverParts[#leftoverParts + 1] = pi end
end
local matched = #planeParts - #leftoverParts
local nextBox = 1
for _, pi in ipairs(leftoverParts) do
	while nextBox <= #BOXES and usedBox[nextBox] do nextBox = nextBox + 1 end
	if nextBox > #BOXES then break end
	boxOf[pi] = nextBox
	usedBox[nextBox] = true
end
local parts, items = {}, {}
for pi, part in ipairs(planeParts) do
	local bi = boxOf[pi]
	if bi then
		parts[#parts + 1] = part
		items[#items + 1] = BOXES[bi]
	end
end
say(("Matched %d/%d parts by colour+size (%d paired blindly). Run script 1 again if this is low."):format(matched, #BOXES, #parts - matched))
assert(#parts > 0, "[Hunter] nothing to animate")

if CFG.BREAK_JOINTS then
	local cut = 0
	for _, p in ipairs(parts) do
		pcall(function()
			for _, j in ipairs(p:GetJoints()) do j:Destroy() cut = cut + 1 end
		end)
		pcall(function()
			for _, c in ipairs(p:GetChildren()) do
				if c:IsA("Weld") or c:IsA("WeldConstraint") or c:IsA("ManualWeld") or c:IsA("Motor6D") then c:Destroy() cut = cut + 1 end
			end
		end)
		pcall(function() p.Anchored = false p.CanCollide = false end)
	end
	print("[Hunter] joints cut: " .. cut)
end

----------------------------------------------------------------------
-- state
----------------------------------------------------------------------
getgenv().HunterRunning = true
local cam = workspace.CurrentCamera
local oldCamType, oldCamSubject = cam.CameraType, cam.CameraSubject

local startPos = (function()
	local c = Vector3.zero
	for _, p in ipairs(parts) do c = c + p.Position end
	c = c / #parts
	return V3(c.X, c.Y, c.Z)
end)()
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local filt = { plane }
if lp.Character then table.insert(filt, lp.Character) end
rayParams.FilterDescendantsInstances = filt
local function groundAt(p, fallback)
	local hit = workspace:Raycast(p + V3(0, 60, 0), V3(0, -600, 0), rayParams)
	return hit and hit.Position.Y or fallback
end

local FOOT_LIFT = 0.62 * SCALE          -- the mesh bottom sits 0.62 in under the model origin
local st = {
	pos = V3(startPos.X, startPos.Y, startPos.Z),
	heading = V3(0, 0, -1),
	vy = 0, grounded = false,
	groundY = startPos.Y - 20,
	runTime = 0,
	prowl = false, runHeld = false,
	lock = 0,                    -- seconds the current action still blocks movement
	camYaw = 0, camPitch = math.rad(18), camDist = CFG.CAM_DIST,
	mx = 0, my = 0,              -- movement input (x right, y forward) in -1..1
	alive = true,
}
st.pos = V3(startPos.X, startPos.Y + 8, startPos.Z)
st.groundY = groundAt(st.pos, startPos.Y - 20)
-- look away from the camera start
st.camYaw = math.atan2(-st.heading.X, -st.heading.Z)

local cur = { clip = CLIPS.idle, t = 0, rate = 1 }
local fade = nil     -- { pose = snapshot, t = 0 }
local lastPose = sampleClip(CLIPS.idle, 0)
local function play(name, rate)
	local clip = CLIPS[name]
	if not clip then return end
	if cur.clip == clip and clip.loop then
		cur.rate = rate or 1
		return
	end
	fade = { pose = lastPose, t = 0 }
	cur = { clip = clip, t = 0, rate = rate or 1 }
end
local function doAction(name, lockTime)
	if st.lock > 0 or not st.grounded then return end
	play(name, 1)
	st.lock = lockTime or CLIPS[name].length
	cur.action = name
end

local function jump()
	if st.lock > 0 or not st.grounded then return end
	st.vy = CFG.JUMP_VELOCITY
	st.grounded = false
	st.jumping = true
	play("leap", 1)
end

----------------------------------------------------------------------
-- input: keyboard / mouse
----------------------------------------------------------------------
local keys = {}
local conns = {}
local function bind(sig, fn) conns[#conns + 1] = sig:Connect(fn) end
local function stop()
	if not st.alive then return end
	st.alive = false
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	pcall(function() cam.CameraType = oldCamType cam.CameraSubject = oldCamSubject end)
	pcall(function() UIS.MouseBehavior = Enum.MouseBehavior.Default end)
	pcall(function() sg:Destroy() end)
	getgenv().HunterRunning = false
	getgenv().HunterStop = nil
end
getgenv().HunterStop = stop

local rmbDown = false
bind(UIS.InputBegan, function(input, gp)
	if gp then return end
	local kc = input.KeyCode
	if input.UserInputType == Enum.UserInputType.Keyboard then
		keys[kc] = true
		if kc == Enum.KeyCode.Space then jump()
		elseif kc == Enum.KeyCode.E then doAction("roar")
		elseif kc == Enum.KeyCode.F then doAction("melee")
		elseif kc == Enum.KeyCode.Q then doAction("shoot")
		elseif kc == Enum.KeyCode.G then doAction("flinch")
		elseif kc == Enum.KeyCode.C then st.prowl = not st.prowl
		elseif kc == Enum.KeyCode.X then stop() end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		doAction("melee")
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
		rmbDown = true
		UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	end
end)
bind(UIS.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then keys[input.KeyCode] = nil
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
		rmbDown = false
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end)
local function clampPitch() st.camPitch = math.clamp(st.camPitch, math.rad(-10), math.rad(75)) end
bind(UIS.InputChanged, function(input, gp)
	if input.UserInputType == Enum.UserInputType.MouseMovement and rmbDown then
		st.camYaw = st.camYaw - input.Delta.X * 0.005
		st.camPitch = st.camPitch + input.Delta.Y * 0.005
		clampPitch()
	elseif input.UserInputType == Enum.UserInputType.MouseWheel and not gp then
		st.camDist = math.clamp(st.camDist - input.Position.Z * 12, CFG.CAM_MIN, CFG.CAM_MAX)
	end
end)

----------------------------------------------------------------------
-- input: touch (joystick, buttons, camera drag, pinch)
----------------------------------------------------------------------
local joyInput, camInput, camLast
local joyVec = Vector2.new(0, 0)
local holdRun = false
if isTouch then
	local vp = cam.ViewportSize
	local U = math.clamp(math.min(vp.X, vp.Y) * 0.15, 54, 96)    -- base unit for touch targets
	local function mkRound(parent, size, pos, anchor, text, color)
		local b = Instance.new("TextButton")
		b.Size = UDim2.fromOffset(size, size)
		b.Position = pos
		b.AnchorPoint = anchor or Vector2.new(0, 0)
		b.BackgroundColor3 = color or Color3.fromRGB(30, 34, 44)
		b.BackgroundTransparency = 0.35
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Font = Enum.Font.GothamBold
		b.TextScaled = true
		b.Text = text
		b.AutoButtonColor = true
		b.Parent = parent
		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(1, 0)
		c.Parent = b
		local tc = Instance.new("UITextSizeConstraint")
		tc.MaxTextSize = math.floor(size * 0.3)
		tc.Parent = b
		return b
	end
	-- joystick
	local base = Instance.new("Frame")
	base.Size = UDim2.fromOffset(U * 2.2, U * 2.2)
	base.Position = UDim2.new(0, U * 0.6, 1, -U * 0.6)
	base.AnchorPoint = Vector2.new(0, 1)
	base.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	base.BackgroundTransparency = 0.82
	base.Active = true
	base.Parent = sg
	local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(1, 0) bc.Parent = base
	local knob = Instance.new("Frame")
	knob.Size = UDim2.fromOffset(U * 0.95, U * 0.95)
	knob.AnchorPoint = Vector2.new(0.5, 0.5)
	knob.Position = UDim2.fromScale(0.5, 0.5)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	knob.BackgroundTransparency = 0.35
	knob.Parent = base
	local kc = Instance.new("UICorner") kc.CornerRadius = UDim.new(1, 0) kc.Parent = knob
	local function joyUpdate(pos)
		local c = base.AbsolutePosition + base.AbsoluteSize / 2
		local r = base.AbsoluteSize.X / 2
		local d = Vector2.new(pos.X, pos.Y) - c
		local m = math.min(d.Magnitude, r)
		local v = d.Magnitude > 0 and d.Unit * m or Vector2.new(0, 0)
		joyVec = v / r
		if joyVec.Magnitude < 0.12 then joyVec = Vector2.new(0, 0) end
		knob.Position = UDim2.new(0.5, v.X, 0.5, v.Y)
	end
	bind(base.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.Touch and not joyInput then
			joyInput = input
			joyUpdate(input.Position)
		end
	end)
	-- action buttons (right side)
	local R = Vector2.new(1, 1)
	local function pos(dx, dy) return UDim2.new(1, -U * dx, 1, -U * dy) end
	local bJump = mkRound(sg, U * 1.15, pos(0.5, 0.5), R, "JUMP", Color3.fromRGB(60, 120, 200))
	local bAtk = mkRound(sg, U * 1.0, pos(1.85, 0.4), R, "ATK", Color3.fromRGB(200, 70, 70))
	local bRoar = mkRound(sg, U * 0.9, pos(0.4, 1.85), R, "ROAR", Color3.fromRGB(200, 140, 50))
	local bShoot = mkRound(sg, U * 0.9, pos(1.5, 1.7), R, "SHOT", Color3.fromRGB(150, 70, 180))
	local bRun = mkRound(sg, U * 1.0, pos(2.9, 0.4), R, "RUN", Color3.fromRGB(60, 160, 90))
	local bSneak = mkRound(sg, U * 0.7, pos(2.8, 1.65), R, "SNEAK", Color3.fromRGB(90, 90, 110))
	local bStop = mkRound(sg, U * 0.6, UDim2.new(1, -U * 0.3, 0, U * 0.3), Vector2.new(1, 0), "X", Color3.fromRGB(120, 30, 30))
	bind(bJump.Activated, jump)
	bind(bAtk.Activated, function() doAction("melee") end)
	bind(bRoar.Activated, function() doAction("roar") end)
	bind(bShoot.Activated, function() doAction("shoot") end)
	bind(bSneak.Activated, function()
		st.prowl = not st.prowl
		bSneak.BackgroundColor3 = st.prowl and Color3.fromRGB(200, 200, 80) or Color3.fromRGB(90, 90, 110)
	end)
	bind(bStop.Activated, stop)
	bind(bRun.InputBegan, function(i) if i.UserInputType == Enum.UserInputType.Touch then holdRun = true end end)
	bind(bRun.InputEnded, function(i) if i.UserInputType == Enum.UserInputType.Touch then holdRun = false end end)
	-- camera drag: any touch that did not land on the interface
	bind(UIS.InputBegan, function(input, gp)
		if gp or input.UserInputType ~= Enum.UserInputType.Touch then return end
		if input ~= joyInput and not camInput then
			camInput, camLast = input, input.Position
		end
	end)
	bind(UIS.InputChanged, function(input)
		if input == joyInput then
			joyUpdate(input.Position)
		elseif input == camInput then
			local d = input.Position - camLast
			camLast = input.Position
			st.camYaw = st.camYaw - d.X * 0.008
			st.camPitch = st.camPitch + d.Y * 0.008
			clampPitch()
		end
	end)
	bind(UIS.InputEnded, function(input)
		if input == joyInput then
			joyInput = nil
			joyVec = Vector2.new(0, 0)
			knob.Position = UDim2.fromScale(0.5, 0.5)
		elseif input == camInput then
			camInput = nil
		end
	end)
	bind(UIS.TouchPinch, function(_positions, scale, _velocity, state)
		if state == Enum.UserInputState.Change and scale > 0 then
			st.camDist = math.clamp(st.camDist / (1 + (scale - 1) * 0.15), CFG.CAM_MIN, CFG.CAM_MAX)
		end
	end)
end
if isMobile then
	say("Hunter ready. Left stick = move, RUN = faster (hold ~1.5s to charge), drag screen = camera, pinch = zoom.", 10)
else
	say("Hunter ready. WASD move | Shift run (hold to charge) | C sneak | Space leap | LMB/F melee | E roar | Q shoot | G flinch | RMB drag camera | X stop", 12)
end

----------------------------------------------------------------------
-- main loop
----------------------------------------------------------------------
local cfs = table.create and table.create(#items) or {}
for i = 1, #items do cfs[i] = CFrame.identity end
local frame = 0
local lastTick = os.clock()

local function readMove()
	local x, y = 0, 0
	if keys[Enum.KeyCode.W] or keys[Enum.KeyCode.Up] then y = y + 1 end
	if keys[Enum.KeyCode.S] or keys[Enum.KeyCode.Down] then y = y - 1 end
	if keys[Enum.KeyCode.D] or keys[Enum.KeyCode.Right] then x = x + 1 end
	if keys[Enum.KeyCode.A] or keys[Enum.KeyCode.Left] then x = x - 1 end
	if joyInput then x, y = x + joyVec.X, y - joyVec.Y end
	local m = math.sqrt(x * x + y * y)
	if m > 1 then x, y, m = x / m, y / m, 1 end
	return x, y, m
end

local function step(dt)
	local mx, my, mag = readMove()
	local camCF = CFrame.Angles(0, st.camYaw, 0)
	local wantDir = nil
	if mag > 0.05 then
		-- camCF looks away from the camera, so LookVector is "forward" on screen
		local d = camCF.RightVector * mx + camCF.LookVector * my
		d = V3(d.X, 0, d.Z)
		if d.Magnitude > 0.01 then wantDir = d.Unit end
	end
	local running = holdRun or keys[Enum.KeyCode.LeftShift] or keys[Enum.KeyCode.RightShift]
	if wantDir and running and st.lock <= 0 then st.runTime = st.runTime + dt else st.runTime = 0 end

	if st.lock > 0 then st.lock = st.lock - dt end

	-- turning + speed
	local clipName, speed = "idle", 0
	local locked = st.lock > 0
	if st.grounded and not locked then
		if wantDir then
			local cross = st.heading.X * wantDir.Z - st.heading.Z * wantDir.X
			local dot = st.heading:Dot(wantDir)
			local ang = math.atan2(cross, dot)
			local rate = (st.runTime > CFG.CHARGE_AFTER) and 2.6 or 5.5
			local turn = math.clamp(ang, -rate * dt, rate * dt)
			local c, s = math.cos(turn), math.sin(turn)
			st.heading = V3(st.heading.X * c - st.heading.Z * s, 0, st.heading.X * s + st.heading.Z * c).Unit
			if st.runTime > CFG.CHARGE_AFTER then clipName = "charge"
			elseif running then clipName = "canter"
			elseif st.prowl or mag < 0.45 then clipName = "prowl"
			else clipName = "walk" end
			local facing = math.max(0, st.heading:Dot(wantDir))
			speed = CLIPS[clipName].speed * CFG.SPEED_SCALE * (0.2 + 0.8 * facing)
		end
	elseif not st.grounded and wantDir then
		-- slight air control
		st.heading = (st.heading * (1 - 2 * dt) + wantDir * (2 * dt)).Unit
		speed = 18
	end

	-- animation selection
	if st.grounded and not locked then
		if st.jumping then
			st.jumping = false
			play("land", 1)
			st.lock = 0.45
			cur.action = "land"
		else
			local clip = CLIPS[clipName]
			if cur.clip ~= clip or cur.action then
				cur.action = nil
				play(clipName, 1)
			end
			-- playback follows the real ground speed so the feet do not slide
			if clip.speed > 0 then cur.rate = math.max(0.1, speed / clip.speed) else cur.rate = 1 end
		end
	end

	-- physics
	local forward = st.heading * speed * dt
	st.pos = st.pos + V3(forward.X, 0, forward.Z)
	local gy = groundAt(V3(st.pos.X, st.pos.Y, st.pos.Z), st.groundY)
	st.groundY = gy
	local targetY = gy + FOOT_LIFT
	if st.grounded then
		-- follow the terrain
		st.pos = V3(st.pos.X, st.pos.Y + (targetY - st.pos.Y) * math.min(1, dt * 14), st.pos.Z)
		if st.pos.Y > targetY + 6 then st.grounded = false st.vy = 0 end
	else
		st.vy = st.vy - workspace.Gravity * dt
		local ny = st.pos.Y + st.vy * dt
		if ny <= targetY and st.vy <= 0 then
			ny = targetY
			st.grounded = true
			st.vy = 0
		end
		st.pos = V3(st.pos.X, ny, st.pos.Z)
	end

	-- advance the clip
	cur.t = cur.t + dt * cur.rate
	local pose = sampleClip(cur.clip, cur.t)
	if fade then
		fade.t = fade.t + dt
		local a = fade.t / CFG.FADE
		if a >= 1 then fade = nil else pose = blendPose(fade.pose, pose, a) end
	end
	lastPose = pose
	return pose
end

local function updateCamera(dt)
	local focus = st.pos + V3(0, CFG.CAM_HEIGHT * (st.camDist / CFG.CAM_DIST) ^ 0.5, 0)
	local rot = CFrame.Angles(0, st.camYaw, 0) * CFrame.Angles(-st.camPitch, 0, 0)
	local pos = focus + (rot * V3(0, 0, st.camDist))
	cam.CameraType = Enum.CameraType.Scriptable
	cam.CFrame = CFrame.lookAt(pos, focus)
end

bind(RunService.RenderStepped, function()
	if not st.alive then return end
	local now = os.clock()
	local dt = math.min(now - lastTick, 0.1)
	lastTick = now
	frame = frame + 1
	local pose = step(dt)
	updateCamera(dt)
	if isMobile and frame % CFG.MOBILE_UPDATE_EVERY ~= 0 then return end
	local W = worldPose(pose)
	local base = CFrame.lookAt(st.pos, st.pos + st.heading) * FRONT
	for i = 1, #items do
		local b = items[i]
		cfs[i] = base * W[b.bone] * b.cf
	end
	local ok = pcall(function() workspace:BulkMoveTo(parts, cfs, Enum.BulkMoveMode.FireCFrameChanged) end)
	if not ok then
		for i = 1, #parts do parts[i].CFrame = cfs[i] end
	end
	if frame % 3 == 0 then
		for i = 1, #parts do
			local p = parts[i]
			p.AssemblyLinearVelocity = Vector3.zero
			p.AssemblyAngularVelocity = Vector3.zero
		end
	end
end)
