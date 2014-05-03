package com.rockmatch.utils
{
	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameUtils
	{
		static private const CHIP_TYPES_QUANTITY:uint = 6;

		//==============================================================================
		//{region							PUBLIC METHODS
		static public function generateRandomChipID():int
		{
			var chip_id:int = Utils.randomNumber(1, CHIP_TYPES_QUANTITY);
			return chip_id;
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}