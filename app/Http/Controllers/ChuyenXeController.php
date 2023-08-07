<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Chuyenxe;
use App\Models\Lotrinh;
use App\Models\Xe;
use App\Http\Controllers\FunctionBase;
class ChuyenXeController extends Controller
{
    //Phần chuyến xe
    public function chuyenxe() {
        $chuyenxe = DB::table('chuyen_xe')->join('employee','chuyen_xe.Mã_nhân_viên_tạo','=','employee.Mã')
            ->join('lo_trinh','chuyen_xe.Mã_lộ_trình','=','lo_trinh.Mã')->join('xe','chuyen_xe.Mã_xe','=','xe.Mã')
            ->join('bus_model','xe.Mã_loại_xe','=','bus_model.Mã')
            ->join('employee as employee1','chuyen_xe.Mã_tài_xế','=','employee1.Mã')
            ->where('chuyen_xe.is_del','=','0')
            ->select('chuyen_xe.Mã','employee.Họ_Tên as Nhân_viên_tạo','employee1.Họ_Tên as Tài_xế','lo_trinh.Nơi_đi','lo_trinh.Nơi_đến','xe.Biển_số','chuyen_xe.Tiền_vé','bus_model.Loại_ghế','chuyen_xe.Ngày_xuất_phát','chuyen_xe.Giờ_xuất_phát','chuyen_xe.Trạng_thái')
            ->orderBy('chuyen_xe.Mã','desc')
			->get();
        return view("quantrivien.chuyenxe",compact('chuyenxe'));
    }
    public function addchuyenxe($id = "") {
        $lotrinhs = Lotrinh::all();
        $taixes = DB::table('employee')->where('Loại_NV','=','TX')->select('Mã','Họ_Tên')->get();
        $xes = Xe::all();
        if($id == "") {
            return view("quantrivien.addchuyenxe",compact('lotrinhs','taixes','xes'));
        }
        else {
            $ttchuyenxes = DB::table('chuyen_xe')->join('employee','chuyen_xe.Mã_nhân_viên_tạo','=','employee.Mã')
                ->join('lo_trinh','chuyen_xe.Mã_lộ_trình','=','lo_trinh.Mã')->join('xe','chuyen_xe.Mã_xe','=','xe.Mã')
                ->join('employee as employee1','chuyen_xe.Mã_tài_xế','=','employee1.Mã')
                ->where('chuyen_xe.Mã','=',$id)
                ->select('chuyen_xe.Mã','chuyen_xe.Mã_nhân_viên_tạo','employee.Họ_Tên as Nhân_viên_tạo','chuyen_xe.Mã_tài_xế','employee1.Họ_Tên as Tài_xế','chuyen_xe.Mã_lộ_trình','lo_trinh.Nơi_đi','lo_trinh.Nơi_đến','chuyen_xe.Mã_xe','xe.Biển_số','chuyen_xe.Ngày_xuất_phát','chuyen_xe.Giờ_xuất_phát','chuyen_xe.Tiền_vé','chuyen_xe.Trạng_thái')
                ->get();
            $ticket = DB::table('ve')->join('chuyen_xe','ve.Mã_chuyến_xe','=','chuyen_xe.Mã')
                ->join('xe','xe.Mã','=','chuyen_xe.Mã_xe')
                ->join('bus_model','bus_model.Mã','=','xe.Mã_loại_xe')
                ->select('ve.Mã','ve.Mã_chuyến_xe','ve.Mã_nhân_viên_đặt','ve.Mã_khách_hàng','ve.Mã_đặt_vé','ve.Vị_trí_ghế','ve.Trạng_thái','chuyen_xe.Tiền_vé','bus_model.Loại_ghế')
                ->where('Mã_chuyến_xe','=',$id)->get();
            foreach ($ttchuyenxes as $row){
                $ttchuyenxe = $row;
            }
            return view("quantrivien.addchuyenxe",compact('ttchuyenxe','lotrinhs','taixes','xes','ticket'));
        }
    }
    public function addchuyenxexl(Request $request) {
        $idlotrinh = $request->lotrinh;
        $idtaixe = $request->taixe;
        $idxe = $request->xe;
        $employeeid = $request->employeeID;
        $startdate = $request->startdate;
        $starttime = $request->starttime;
        $giave = $request->tien;
        $status = $request->status;
        $created_at = date('Y-m-d h-i-s');
        $updated_at = date('Y-m-d h-i-s');
        if(isset($request->ID)){
            try {
                if(!DB::select("SELECT * FROM chuyen_xe WHERE Mã = ? AND Mã_xe = ?",[$request->ID,$idxe])) {
                    DB::delete('DELETE FROM ve WHERE Mã_chuyến_xe = ?', [$request->ID]);
                    $loaixes = DB::table('xe')->join('bus_model', 'xe.Mã_loại_xe', '=', 'bus_model.Mã')
                        ->where('xe.Mã', '=', $idxe)->select('bus_model.Số_hàng', 'bus_model.Số_cột', 'bus_model.Sơ_đồ','bus_model.Loại_ghế')
                        ->get();
                    foreach ($loaixes as $row) {
                        $loaixe = (array)$row;
                    }
                    $sodo = $loaixe["Sơ_đồ"];
                    $row = intval($loaixe["Số_hàng"]);
                    $col = intval($loaixe["Số_cột"]);
                    $loaighe = $loaixe["Loại_ghế"];
                    $trangthai = 0;
                    $k = 1;
                    if($loaighe==1)
                    {
                        $row = ($row - 1)/2 + 1;
                    }
                    for ($i = 1; $i < $row; $i++) {
//                        $k = 1;
                        for ($j = 0; $j < $col; $j++) {
                            /*if ($i * $col + $j == 0)
                                continue;*/
                            if ($sodo[$i * $col + $j] == 1) {
                                $vitri = 'A-' . ($k);
                                DB::insert("INSERT INTO `ve`(`Mã_chuyến_xe`, `Vị_trí_ghế`, `Trạng_thái`, `created_at`, `updated_at`) VALUES (?,?,?,?,?)",
                                    [$request->ID, $vitri, $trangthai, $created_at, $updated_at]);
                                $k++;
                            }
                        }
                    }
                    if($loaighe==1){
                        $k = 1;
                        for ($i = $row; $i < intval($loaixe["Số_hàng"]); $i++) {
//                        $k = 1;
                            for ($j = 0; $j < $col; $j++) {
                                /*if ($i * $col + $j == 0)
                                    continue;*/
                                if ($sodo[$i * $col + $j] == 1) {
                                    $vitri = 'B-' . ($k);
                                    DB::insert("INSERT INTO `ve`(`Mã_chuyến_xe`, `Vị_trí_ghế`, `Trạng_thái`, `created_at`, `updated_at`) VALUES (?,?,?,?,?)",
                                        [$request->ID, $vitri, $trangthai, $created_at, $updated_at]);
                                    $k++;
                                }
                            }
                        }
                    }
                    DB::update("UPDATE `chuyen_xe` SET `Mã_lộ_trình`= ?,`Mã_tài_xế`= ?,`Mã_xe`= ?,`Tiền_vé`= ?,`Ngày_xuất_phát`= ?,`Giờ_xuất_phát`= ?,`Trạng_thái`= ?,`updated_at`= ? WHERE `Mã`= ?",
                        [$idlotrinh, $idtaixe, $idxe, $giave, $startdate, $starttime, $status, $updated_at, $request->ID]);
                }
                else{
                    DB::update("UPDATE `chuyen_xe` SET `Mã_lộ_trình`= ?,`Mã_tài_xế`= ?,`Mã_xe`= ?,`Tiền_vé`= ?,`Ngày_xuất_phát`= ?,`Giờ_xuất_phát`= ?,`Trạng_thái`= ?,`updated_at`= ? WHERE `Mã`= ?",
                        [$idlotrinh, $idtaixe, $idxe, $giave, $startdate, $starttime, $status, $updated_at, $request->ID]);
                }
            } catch (\Exception $e) {
                return redirect()->back()->with('alert','Sửa thất bại!');
            }
            return redirect()->back()->with('alert','Sửa thành công!');
        }
        else {
            try {
                /*DB::insert("INSERT INTO `chuyen_xe`(`Mã_nhân_viên_tạo`, `Mã_lộ_trình`, `Mã_tài_xế`, `Mã_xe`, `Thời_gian_xuất_phát`, `created_at`, `updated_at`) VALUES (?,?,?,?,?,?,?)",
                    [$employeeid,$idlotrinh,$idtaixe,$idxe,$starttime,$created_at,$updated_at]);*/
                $id = DB::table("chuyen_xe")->insertGetId([
                    'Mã_nhân_viên_tạo' => $employeeid,
                    'Mã_lộ_trình' => $idlotrinh,
                    'Mã_tài_xế' => $idtaixe,
                    'Mã_xe' => $idxe,
                    'Tiền_vé' => $giave,
                    'Giờ_xuất_phát' => $starttime,
                    'Ngày_xuất_phát' => $startdate,
                    'Trạng_thái' => $status,
                    'created_at' => $created_at,
                    'updated_at' => $updated_at
                ]);
                $loaixes = DB::table('xe')->join('bus_model','xe.Mã_loại_xe','=','bus_model.Mã')
                    ->where('xe.Mã','=',$idxe)->select('bus_model.Số_hàng','bus_model.Số_cột','bus_model.Sơ_đồ','bus_model.Loại_ghế')
                    ->get();
                foreach ($loaixes as $row){
                    $loaixe = (array)$row;
                }
                $sodo = $loaixe["Sơ_đồ"];
                $row = intval($loaixe["Số_hàng"]);
                $col  = intval($loaixe["Số_cột"]);
                $loaighe = $loaixe["Loại_ghế"];
                $trangthai = 0;
                $k = 1;
                if($loaighe==1)
                {
                    $row = ($row - 1)/2 + 1;
                }
                for ($i = 1;$i<$row;$i++){
//                    $k = 1;
                    for ($j = 0;$j<$col;$j++){
                        /*if($i*$col+$j == 0)
                            continue;*/
                        if($sodo[$i*$col+$j]==1){
                            $vitri = 'A-'.($k);
                            DB::insert("INSERT INTO `ve`(`Mã_chuyến_xe`, `Vị_trí_ghế`, `Trạng_thái`, `created_at`, `updated_at`) VALUES (?,?,?,?,?)",
                                [$id,$vitri,$trangthai,$created_at,$updated_at]);
                            $k++;
                        }
                    }
                }
                if($loaighe==1){
                    $k = 1;
                    for ($i = $row; $i < intval($loaixe["Số_hàng"]); $i++) {
//                        $k = 1;
                        for ($j = 0; $j < $col; $j++) {
                            /*if ($i * $col + $j == 0)
                                continue;*/
                            if ($sodo[$i * $col + $j] == 1) {
                                $vitri = 'B-' . ($k);
                                DB::insert("INSERT INTO `ve`(`Mã_chuyến_xe`, `Vị_trí_ghế`, `Trạng_thái`, `created_at`, `updated_at`) VALUES (?,?,?,?,?)",
                                    [$id, $vitri, $trangthai, $created_at, $updated_at]);
                                $k++;
                            }
                        }
                    }
                }
                return redirect()->back()->with('alert','Thêm thành công!');
            }  catch (\Exception $e) {
                /*return \response()->json(['result'=>'0']);*/
                /*return redirect()->back()->with('alert','Thêm thất bại!');*/
                die($e);
            }
        }
    }
    public function delchuyenxe($id = "") {
        $updated_at = date('Y-m-d h-i-s');
        if($id == "")
            return redirect()->back();
        else {
            try {
                DB::update("UPDATE `chuyen_xe` SET `is_del`= ?,`updated_at`= ? WHERE `Mã`= ?",
                    [1,$updated_at,$id]);
            } catch (\Exception $e) {
                return redirect()->back();
            }
            return redirect()->back();
        }
    }
}
