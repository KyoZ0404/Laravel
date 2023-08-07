<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Khachhang;
class KhachHangController extends Controller
{
    //Phần khách hàng
    public function khachhang()
	{
        $customer = Khachhang::all();
        return view('quantrivien.khachhang', compact('customer'));
    }

    public function addkhachhang($index="")
	{
        if($index=="")
		{
            return view("quantrivien.addkhachhang");
        }
        try 
		{
            $ttkhachhangs = DB::select("SELECT * FROM customer WHERE Mã = ?",[$index]);
            foreach ($ttkhachhangs as $row)
			{
                $ttkhachhang = $row;
            }
            return view("quantrivien.addkhachhang",["ttkhachhang" => $ttkhachhang]);
        } 
		catch (\Exception $e) 
		{
            die("Lỗi: ".$e);
        }
    }

    public  function addcustomer(Request $request)
	{
        $name = $request->name;
		$tenkhongdau = FunctionBase::convertAlias($name);
        $brtday = $request->brtday;
        $gender = $request->gender;
        $address = $request->address;
        $password = md5($request->password);
        $email = $request->email;
        $phone = $request->phone;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(isset($request->ID))
		{
            if(DB::update("UPDATE `customer` SET `Tên`= ?,`Tên_không_dấu`= ?,`Ngày_sinh`= ?,`Giới tính`= ?,`Địa chỉ`= ?,`Password`= ?,`Email`= ?,`Sđt`= ?,`updated_at`= ? WHERE `Mã`= ?",
                [$name,$tenkhongdau,$brtday,$gender,$address,$password,$email,$phone,$updated_at,$request->ID]))
				{
					return redirect()->back()->with('alert','Sửa thành công!');
				}
            else
			{
				return redirect()->back()->with('alert','Sửa thất bại!');
			}
        }
        else 
		{
            if(!DB::select('select * from customer where Email = ? or Sđt = ? or Tên = ?',[$request->email,$request->phone,$request->name]))
            {
                DB::insert("INSERT INTO `customer`(`Tên`, `Tên_không_dấu`, `Ngày_sinh`, `Giới tính`, `Địa chỉ`, `Password`, `Email`, `Sđt`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?,?,?,?,?)",
                    [$name,$tenkhongdau,$brtday,$gender,$address,$password,$email,$phone,$created_at,$updated_at]);
                return redirect()->back()->with('alert','Thêm thành công!');
            }
            else
			{
				return redirect()->back()->with('alert','Thêm thất bại!');
			}      
        }
    }

    public function delcustomer($id)
	{
        try 
		{
            DB::delete('DELETE FROM customer WHERE Mã = ?',[$id]);
        } 
		catch (\Exception $e) 
		{
            die("Lỗi xóa dữ liệu :".$e);
        }
        return redirect()->back();
    }
    public function viewkhachhang($id = "")
	{
        if ($id == "")
		{
			return redirect(url('admin/khachhang'));
		}            
        $ttkhachhangs = DB::table('customer')->where('Mã','=',$id)->get();
        foreach ($ttkhachhangs as $row)
		{
            $ttkhachhang = (array)$row;
        }
        $ttchuyendi = DB::table('ve')->join('chuyen_xe','ve.Mã_chuyến_xe','=','chuyen_xe.Mã')
            ->join('lo_trinh','chuyen_xe.Mã_lộ_trình','=','lo_trinh.Mã')
            ->where('ve.Mã_khách_hàng','=',$id)
            ->select('lo_trinh.Nơi_đi','lo_trinh.Nơi_đến','ve.Vị_trí_ghế','chuyen_xe.Tiền_vé')
            ->get();
        return view('quantrivien.viewkhachhang',compact('ttkhachhang','ttchuyendi'));
    }
}
