<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Ve;
use Illuminate\Support\Facades\DB;
class VeController extends Controller
{
    //Phần vé
    public function ve () {
        $ticket = DB::table('ve')->join('chuyen_xe','ve.Mã_chuyến_xe','=','chuyen_xe.Mã')
            ->join('xe','xe.Mã','=','chuyen_xe.Mã_xe')
            ->join('bus_model','bus_model.Mã','=','xe.Mã_loại_xe')
            ->select('ve.Mã','ve.Mã_chuyến_xe','ve.Mã_nhân_viên_đặt','ve.Mã_khách_hàng','ve.Mã_đặt_vé','ve.Vị_trí_ghế','ve.Trạng_thái','chuyen_xe.Tiền_vé','bus_model.Loại_ghế')
            ->get();
        return view('quantrivien.ve',['ticket'=>$ticket]);
    }
    public function ticket($index,$id = '') {
        if ($index==1&&$id==''){
            $chuyenxe = DB::table('chuyen_xe')->join('employee','chuyen_xe.Mã_nhân_viên_tạo','=','employee.Mã')
                ->join('lo_trinh','chuyen_xe.Mã_lộ_trình','=','lo_trinh.Mã')->join('xe','chuyen_xe.Mã_xe','=','xe.Mã')
                ->join('bus_model','xe.Mã_loại_xe','=','bus_model.Mã')
                ->join('employee as employee1','chuyen_xe.Mã_tài_xế','=','employee1.Mã')
                ->where('chuyen_xe.is_del','=','0')
                ->select('chuyen_xe.Mã','employee.Họ_Tên as Nhân_viên_tạo','employee1.Họ_Tên as Tài_xế','lo_trinh.Nơi_đi','lo_trinh.Nơi_đến','xe.Biển_số','chuyen_xe.Tiền_vé','bus_model.Loại_ghế','chuyen_xe.Ngày_xuất_phát','chuyen_xe.Giờ_xuất_phát','chuyen_xe.Trạng_thái')
                ->orderBy('chuyen_xe.Mã','desc')
				->get();
            return \response()->json(['msg'=>$chuyenxe]);
        }
        elseif ($index==2&&$id==''){
            $ticket = DB::table('ve')->join('chuyen_xe','ve.Mã_chuyến_xe','=','chuyen_xe.Mã')
                ->join('xe','xe.Mã','=','chuyen_xe.Mã_xe')
                ->join('bus_model','bus_model.Mã','=','xe.Mã_loại_xe')
                ->select('ve.Mã','ve.Mã_chuyến_xe','ve.Mã_nhân_viên_đặt','ve.Mã_khách_hàng','ve.Mã_đặt_vé','ve.Vị_trí_ghế','ve.Trạng_thái','chuyen_xe.Tiền_vé','bus_model.Loại_ghế')
                ->get();
            return \response()->json(['msg'=>$ticket]);
        }
        elseif ($index==2&&$id!=''){
            $ticket = DB::table('ve')->join('chuyen_xe','ve.Mã_chuyến_xe','=','chuyen_xe.Mã')
                ->join('xe','xe.Mã','=','chuyen_xe.Mã_xe')
                ->join('bus_model','bus_model.Mã','=','xe.Mã_loại_xe')
                ->where('ve.Mã_chuyến_xe','=',$id)
                ->select('ve.Mã','ve.Mã_chuyến_xe','ve.Mã_nhân_viên_đặt','ve.Mã_khách_hàng','ve.Mã_đặt_vé','ve.Vị_trí_ghế','ve.Trạng_thái','chuyen_xe.Tiền_vé','bus_model.Loại_ghế')
                ->get();
            return \response()->json(['msg'=>$ticket]);
        }
    }
    public function editticket(Request $request) {
        $id = $request->ID;
        $trangthai = $request->trangthai;
        $updated_at = date('Y-m-d h-i-s');
        try {
            DB::update("UPDATE `ve` SET `Trạng_thái`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$trangthai,$updated_at,$id]);
        } catch (\Exception $e) {
            return \response()->json(['result'=>0]);
        }
        return \response()->json(['result'=>1]);
    }
    public function delve($id)
	{
        try 
		{
            DB::delete('DELETE FROM ve WHERE Mã = ?',[$id]);
        } 
		catch (\Exception $e) 
		{
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
}
