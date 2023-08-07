<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Nhanvien;
class NhanvienController extends Controller
{
    //Phần nhân viên
    public function nhanvien(){
        $nhanvien = Nhanvien::all();
        return view("quantrivien.nhanvien",["employee"=>$nhanvien]);
    }
    public function addnhanvien($index = ""){
        if($index == ""){
            return view("quantrivien.addnhanvien");
        }
        try {
            $ttnhanviens = DB::select("SELECT * FROM employee WHERE Mã = ?",[$index]);
            foreach ($ttnhanviens as $row){
                $ttnhanvien = $row;
            }
            return view("quantrivien.addnhanvien",["ttnhanvien" => $ttnhanvien]);
        } catch (\Exception $e) {
            die("Lỗi: ".$e);
        }
    }
    public  function addemployee(Request $request){
        $name = $request->name;
        $brtday = $request->brtday;
        $gender = $request->gender;
        $address = $request->address;
        $username = $request->username;
        $password = md5($request->password);
        $email = $request->email;
        $phone = $request->phone;
        $type = $request->typenv;
        $banglai = $request->banglai;
        $chinhanh = $request->chinhanh;
        $datestart = $request->datestart;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(isset($request->ID)){
            if(DB::update("UPDATE `employee` SET `Họ_Tên`= ?,`Ngày_sinh`= ?,`Giới_tính`= ?,`Địa_chỉ`= ?,`Username`= ?,`Password`= ?,`Email`= ?,`Sđt`= ?,`Loại_NV`= ?,`Bằng_lái`= ?,`Chi_nhánh`= ?,`Date_Starting`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$name,$brtday,$gender,$address,$username,$password,$email,$phone,$type,$banglai,$chinhanh,$datestart,$updated_at,$request->ID]))
                return redirect()->back()->with('alert','Sửa thành công!');
            else
                return redirect()->back()->with('alert','Sửa thất bại!');
        }
        else {
            if(!DB::select('select * from employee where Email = ? or Sđt = ? or Họ_Tên = ?',[$request->email,$request->phone,$request->name]))
            {
                DB::insert("INSERT INTO `employee`(`Họ_Tên`, `Ngày_sinh`, `Giới_tính`, `Địa_chỉ`, `Username`, `Password`, `Email`, `Sđt`, `Loại_NV`,`Bằng_lái`,`Chi_nhánh`,`Date_Starting`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                    [$name,$brtday,$gender,$address,$username,$password,$email,$phone,$type,$banglai,$chinhanh,$datestart,$created_at,$updated_at]);
                return redirect()->back()->with('alert','Thêm thành công!');
            }
            else
                return redirect()->back()->with('alert','Thêm thất bại!');
        }
    }
    public function delemployee($id){
        try {
            DB::delete('DELETE FROM employee WHERE Mã = ?',[$id]);
        } catch (\Exception $e) {
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
	public function userinfo(Request $request)
	{
		$id = $request->id;
		$ttnhanvien = DB::table('employee')->where('Mã','=',$id)->get();
		if($ttnhanvien)
		{
			sleep(1);
			return response()->json(['kq' => 1,'userinfo' => $ttnhanvien]);
		}
		return response()->json(['kq' => 0]);
	}
}
