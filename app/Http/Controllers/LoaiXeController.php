<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Loaixe;
class LoaiXeController extends Controller
{
     //Phần loại xe
     public function loaixe(){
        $busmodel = Loaixe::all();
        return view('quantrivien.loaixe',compact('busmodel'));
    }
    public function addbusmodel(Request $request){
        $name = $request->name;
        $row = $request->row;
        $col = $request->col;
        $employeeid = $request->employeeID;
        $soghe = $request->soghe;
        $sodo = $request->noidung;
        $loaighe =$request->loaighe;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(!empty($request->ID)) {
            if (DB::update("UPDATE `bus_model` SET `Tên_Loại`= ?,`Loại_ghế`= ?,`Số_ghế`= ?,`Số_hàng`= ?,`Số_cột`= ?,`Sơ_đồ`= ?,`Mã_nhân_viên_chỉnh_sửa`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$name, $loaighe, $soghe, $row, $col, $sodo, $employeeid, $updated_at, $request->ID]))
            {
                return redirect()->back()->with('alert', 'Sửa thành công!');
            }
            else
                return redirect()->back()->with('alert','Sửa thất bại!');
        }
        else {
            if( DB::insert("INSERT INTO `bus_model`(`Tên_Loại`, `Loại_ghế`, `Số_ghế`, `Số_hàng`, `Số_cột`, `Sơ_đồ`, `Mã_nhân_viên_tạo`, `Mã_nhân_viên_chỉnh_sửa`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?,?,?,?,?)",
                [$name,$loaighe,$soghe,$row,$col,$sodo,$employeeid,$employeeid,$created_at,$updated_at]))
            {
                return redirect()->back()->with('alert','Thêm thành công!');
            }
            else
                return redirect()->back()->with('alert','Thêm thất bại!');
        }
    }
    public function delbusmodel($id){
        try {
            DB::delete('DELETE FROM bus_model WHERE Mã = ?',[$id]);
        } catch (\Exception $e) {
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
}
