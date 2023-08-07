<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Tramdung;
class TramDungController extends Controller
{
     //Phần trạm dừng
     public function tramdung(){
        $busstop = DB::table('tram_dung')->join('employee','tram_dung.Mã_nhân_viên_tạo','=','employee.Mã')
            ->join('employee as employee1','tram_dung.Mã_nhân_viên_chỉnh_sửa','=','employee1.Mã')
            ->select('tram_dung.Mã','tram_dung.Tên','tram_dung.Tọa_độ','tram_dung.Mã_nhân_viên_tạo','tram_dung.Mã_nhân_viên_chỉnh_sửa','employee.Họ_Tên as Nhân_viên_tạo','employee1.Họ_Tên as Nhân_viên_chỉnh_sửa')->get();
        return view("quantrivien.tramdung",compact('busstop'));
    }
    public function addtramdung($index = ""){
        if($index == ""){
            return view("quantrivien.addtramdung");
        }
        try {
            $tttramdungs = DB::select("SELECT * FROM tram_dung WHERE Mã = ?",[$index]);
            foreach ($tttramdungs as $row){
                $tttramdung = $row;
            }
            return view("quantrivien.addtramdung",["tttramdung" => $tttramdung]);
        } catch (\Exception $e) {
            die("Lỗi: ".$e);
        }
    }
    public  function addbusstop(Request $request){
        $name = $request->name;
        $employeeid = $request->employeeID;
        $toado = $request->toado;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(isset($request->ID)){
            if(DB::update("UPDATE `tram_dung` SET `Tên`= ?,`Tọa_độ`= ?,`Mã_nhân_viên_chỉnh_sửa`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$name,$toado,$employeeid,$updated_at,$request->ID]))
                return redirect()->back()->with('alert','Sửa thành công!');
            else
                return redirect()->back()->with('alert','Sửa thất bại!');
        }
        else {
            if( DB::insert("INSERT INTO `tram_dung`(`Tên`, `Tọa_độ`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?)",
                [$name,$toado,$employeeid,$employeeid,$created_at,$updated_at]))
            {
                return redirect()->back()->with('alert','Thêm thành công!');
            }
            else
                return redirect()->back()->with('alert','Thêm thất bại!');
        }
    }
    public function delbusstop($id){
        try {
            DB::delete('DELETE FROM tram_dung WHERE Mã = ?',[$id]);
        } catch (\Exception $e) {
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
}
