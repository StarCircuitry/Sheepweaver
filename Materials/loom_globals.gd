extends Node


const plain1 = Vector3(0.875, 0.835, 0.812) 
const plain2 = Vector3(0.843, 0.8, 0.773)
const plain3 = Vector3(0.804, 0.765, 0.733)

const clay1 = Vector3(0.769, 0.439, 0.325)
const clay2 =Vector3(0.749, 0.357, 0.275)
const clay3 = Vector3(0.71, 0.286, 0.22)

const turm1 = Vector3(0.945, 0.78, 0.431)
const turm2 = Vector3(0.933, 0.706, 0.353)
const turm3 = Vector3(0.922, 0.643, 0.314)

const lime1 = Vector3(0.498, 0.831, 0.235)
const lime2 = Vector3(0.412, 0.808, 0.224)
const lime3 = Vector3(0.271, 0.784, 0.192)

const blue1 = Vector3(0.353, 0.471, 0.812)
const blue2 = Vector3(0.333, 0.365, 0.796)
const blue3 = Vector3(0.341, 0.306, 0.776)

const purp1 = Vector3(0.749, 0.267, 0.941)
const purp2 = Vector3(0.639, 0.251, 0.875)
const purp3 = Vector3(0.58, 0.259, 0.808)

const pink1 = Vector3(0.976, 0.635, 0.659)
const pink2 = Vector3(0.945, 0.573, 0.596)
const pink3 = Vector3(0.937, 0.529, 0.612)

const black1 = Vector3(0.188, 0.165, 0.157)
const black2 = Vector3(0.165, 0.129, 0.129)
const black3 = Vector3(0.118, 0.098, 0.094)

const PLAIN = [plain1, plain2, plain3]
const CLAY = [clay1, clay2, clay3]
const TURMERIC = [turm1, turm2, turm3]
const LIME = [lime1, lime2, lime3]
const BLUE = [blue1, blue2, blue3]
const PURPLE = [purp1, purp2, purp3]
const PINK = [pink1, pink2, pink3]
const BLACK = [black1, black2, black3]

const colors = [PLAIN, CLAY, TURMERIC, LIME, BLUE, PURPLE, PINK, BLACK]


const PATTERN_1  = [
			[Vector2i(0, 0), Vector2i(13, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(15, 0)], 
			[Vector2i(5, 0), Vector2i(14, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(16, 1)], 
			[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(15, 1)],
			[Vector2i(5, 0), Vector2i(14, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(16, 1)], 
			[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(0, 1)],
			[Vector2i(5, 0), Vector2i(14, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(16, 1)], 
			[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(0, 1)],
			[Vector2i(5, 0), Vector2i(14, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(16, 1)],  
			[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(3, 1), Vector2i(2, 0), Vector2i(0, 1)],
			[Vector2i(5, 0), Vector2i(14, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(2, 1), Vector2i(2, 0), Vector2i(16, 1)]]




const PATTERN_2 = [
				[Vector2i(0, 0), Vector2i(13, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(15, 0)], 
				[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(15, 1)],
				[Vector2i(5, 0), Vector2i(14, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(16, 1)], 
				[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(15, 1)],
				[Vector2i(5, 0), Vector2i(14, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(16, 1)], 
				[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(15, 1)],
				[Vector2i(5, 0), Vector2i(14, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(16, 1)], 
				[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(15, 1)],
				[Vector2i(5, 0), Vector2i(14, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(16, 1)], 
				[Vector2i(5, 0), Vector2i(13, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(15, 1)]
				]

				
const PATTERN_3 = [
			[Vector2i(0, 0), Vector2i(13, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(5, 0), Vector2i(15, 0)],
 			[Vector2i(5, 0), Vector2i(14, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(16, 0)], 
			[Vector2i(5, 0), Vector2i(13, 0), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(0, 0)], 
			[Vector2i(5, 0), Vector2i(14, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(16, 0)],
			[Vector2i(5, 0), Vector2i(13, 0), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(15, 0)], 
			[Vector2i(5, 0), Vector2i(14, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(16, 0)], 
			[Vector2i(5, 0), Vector2i(13, 0), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(15, 0)],
			[Vector2i(5, 0), Vector2i(14, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(16, 0)],  
			[Vector2i(5, 0), Vector2i(13, 0), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(3, 1), Vector2i(4, 1), Vector2i(4, 1), Vector2i(0, 0)], 
			[Vector2i(5, 0), Vector2i(14, 0), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(2, 0), Vector2i(4, 1), Vector2i(4, 1), Vector2i(16, 0)]
			]

const GOAL_PATTERNS = [PATTERN_1, PATTERN_2, PATTERN_3]
