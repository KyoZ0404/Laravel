<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Lotrinh;
use App\Models\Tramdung;
use App\Models\Tinh;
class LoTrinhController extends Controller
{
    //Phần lộ trình
    public function lotrinh($cm =""){
        $busstops = Tramdung::all();
        if($cm == "")
        {
            $busroute = Lotrinh::all();
            $province = Tinh::all();
            return view("quantrivien.lotrinh",compact('busroute','busstops','province'));
        }
        elseif($cm == "1"){
            $busroute = Lotrinh::all();
            return \response()->json(['msg'=>$busroute]);
        }
        elseif($cm == "2"){
            $province = Tinh::all();
            return \response()->json(['msg'=>$province]);
        }
    }
    public function addbusroute(Request $request) {
        $noidi = $request->noidi;
        $noiden = $request->noiden;
        $employeeid = $request->employeeID;
        $thoigiandi = $request->thoigiandi;
        $busstops = $request->busstops;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if($request->ID != ""){
            if(DB::update("UPDATE `lo_trinh` SET `Nơi_đi`= ?,`Nơi_đến`= ?,`Thời_gian_đi_dự_kiến`= ?,`Các_trạm_dừng_chân`= ?,`Mã_nhân_viên_chỉnh_sửa`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$noidi,$noiden,$thoigiandi,$busstops,$employeeid,$updated_at,$request->ID]))
                return \response()->json(['result'=>'1']);
            else
                return \response()->json(['result'=>'0']);
        }
        else {
            if( DB::insert("INSERT INTO `lo_trinh`(`Nơi_đi`, `Nơi_đến`, `Thời_gian_đi_dự_kiến`, `Các_trạm_dừng_chân`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?,?,?)",
                [$noidi,$noiden,$thoigiandi,$busstops,$employeeid,$employeeid,$created_at,$updated_at]))
            {
                return \response()->json(['result'=>'1']);
            }
            else
                return \response()->json(['result'=>'0']);
        }
    }
    public function delbusroute(Request $request) {
        if(isset($request->ID)) {
            try {
                DB::delete('DELETE FROM lo_trinh WHERE Mã = ?',[$request->ID]);
            } catch (\Exception $e) {
                return \response()->json(['result'=>'0']);
            }
            return \response()->json(['result'=>'1']);
        }
    }
	public function admin_getlocations(Request $request)
	{
		$locations = $request->locations;
		$toado = [];
		for($i=0;$i<count($locations);$i++)
		{
			$name = DB::table("tram_dung")->where("Mã","=",$locations[$i])->select("Tên")->get()[0]->Tên;
			$location = explode(",",DB::table("tram_dung")->where("Mã","=",$locations[$i])->select("Tọa_độ")->get()[0]->Tọa_độ);
			$location[2] = $name;
			$toado[$i] = $location;
		}
		return response()->json(['kq' => 1,'data' => $toado]);
	}
}
